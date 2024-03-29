import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';
import 'mytable.dart';

class StockmaxDatabase {
  static final StockmaxDatabase instance = StockmaxDatabase._init();
  static Database? _database;

  StockmaxDatabase._init();

  Future<void> listTables() async {
    final db = await instance.database;
    for (var row
        in (await db.query('sqlite_master', columns: ['type', 'name']))) {
      print(row.values);
    }
  }

  Future<void> deleteAllData() async => databaseFactory
      .deleteDatabase(join(await getDatabasesPath(), 'stockmax.db'));

  Future<Database> get database async {
    return _database == null ? await _initDB('stockmax.db') : _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onConfigure: _configureDataBase,
    );
  }

  Future<void> _configureDataBase(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.item}
    (
      ${MyTable.itemCodeField} TEXT PRIMARY KEY,
      ${MyTable.itemDescriptionField} TEXT,
      ${MyTable.itemQuantityField} REAL,
      ${MyTable.itemUnitField} TEXT,
      ${MyTable.itemCategoryField} TEXT,
      ${MyTable.itemQualityField} TEXT
    )
    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.customer}
    (
      ${MyTable.customerCodeField} TEXT PRIMARY KEY,
      ${MyTable.customerFirstNameField} TEXT,
      ${MyTable.customerLastNameField} REAL,
      ${MyTable.customerAddressField} TEXT,
      ${MyTable.customerEmailField} TEXT
    )
    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.user}
    (
      ${MyTable.userCodeField} TEXT PRIMARY KEY
    )
    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.sale}
    (
      ${MyTable.saleCodeField} TEXT PRIMARY KEY,
      ${MyTable.itemCodeField} TEXT,
      ${MyTable.customerCodeField} TEXT,
      ${MyTable.itemQuantityField} REAL,
      ${MyTable.saleCostField} REAL,
      ${MyTable.saleDateField} TEXT,

      FOREIGN KEY (${MyTable.itemCodeField}) REFERENCES ${MyTable.item} (${MyTable.itemCodeField}) ON UPDATE CASCADE,
      FOREIGN KEY (${MyTable.customerCodeField}) REFERENCES ${MyTable.customer} (${MyTable.customerCodeField}) ON UPDATE CASCADE
    )
    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.supplier}
    (
      ${MyTable.supplierCodeField} TEXT PRIMARY KEY,
      ${MyTable.supplierNameField} TEXT,
      ${MyTable.supplierAddressField} TEXT,
      ${MyTable.supplierEmailField} TEXT
    )
    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.itemPriceAtDate}
    (
      ${MyTable.itemCodeField} TEXT,
      ${MyTable.atDateField} TEXT,
      ${MyTable.itemPriceField} REAL,

      PRIMARY KEY (${MyTable.itemCodeField}, ${MyTable.atDateField}),
      FOREIGN KEY (${MyTable.itemCodeField}) REFERENCES ${MyTable.item} (${MyTable.itemCodeField}) ON UPDATE CASCADE
    )

    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.command}
    (
      ${MyTable.commandCodeField} TEXT PRIMARY KEY,
      ${MyTable.itemCodeField} TEXT,
      ${MyTable.itemQuantityField} REAL,
      ${MyTable.supplierCodeField} TEXT,
      ${MyTable.commandDateField} TEXT,

      FOREIGN KEY (${MyTable.itemCodeField}) REFERENCES ${MyTable.item} (${MyTable.itemCodeField}) ON UPDATE CASCADE,
      FOREIGN KEY (${MyTable.supplierCodeField}) REFERENCES ${MyTable.supplier} (${MyTable.supplierCodeField}) ON UPDATE CASCADE
    )

    ''');

    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS ${MyTable.wastes}
    (
      ${MyTable.wastesCodeField} TEXT PRIMARY KEY,
      ${MyTable.itemCodeField} TEXT,
      ${MyTable.itemQuantityField} REAL,
      ${MyTable.wastesDateField} TEXT,
      ${MyTable.wastesDescriptionField} TEXT,

      FOREIGN KEY (${MyTable.itemCodeField}) REFERENCES ${MyTable.item} (${MyTable.itemCodeField}) ON UPDATE CASCADE
    )

    ''');

    await db.insert(
        MyTable.customer,
        MyCustomer.copy(const MyCustomer(customerCode: MyTable.customerZero))
            .toJson());

    await db.insert(
        MyTable.supplier,
        MySupplier.copy(const MySupplier(
                supplierCode: MyTable.supplierZero, supplierName: 'STOCKMAX'))
            .toJson());
  }

  Future<void> insertItem(MyItem item) async {
    final db = await instance.database;
    await db.insert(MyTable.item, item.toJson());
  }

  Future<void> insertUser(MyUser user) async {
    final db = await instance.database;
    await db.insert(MyTable.user, user.toJson());
  }

  Future<void> insertCustomer(MyCustomer customer) async {
    final db = await instance.database;
    await db.insert(MyTable.customer, customer.toJson());
  }

  Future<void> insertSale(MySale sale) async {
    final db = await instance.database;
    await db.insert(MyTable.sale, sale.toJson());
  }

  Future<void> insertItemPriceAtDate(MyItemPriceAtDate price) async {
    final db = await instance.database;
    await db.insert(MyTable.itemPriceAtDate, price.toJson());
  }

  Future<void> insertSupplier(MySupplier supplier) async {
    final db = await instance.database;
    await db.insert(MyTable.supplier, supplier.toJson());
  }

  Future<void> insertCommand(MyCommand command) async {
    final db = await instance.database;
    await db.insert(MyTable.command, command.toJson());
  }

  Future<void> insertWastes(MyWastes wastes) async {
    final db = await instance.database;
    await db.insert(MyTable.wastes, wastes.toJson());
  }

  Future<Map<String, Object?>> readRow({
    required String tableName,
    required List<String> columnsList,
    required String conditions,
    required List<Object?> whereArgsList,
  }) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: columnsList,
      where: conditions,
      whereArgs: whereArgsList,
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      throw Exception('NO DATA FOUND');
    }
  }

  Future<List<MyWastes>> readAllWastes() async {
    final db = await instance.database;
    final result = await db.query(MyTable.wastes);
    return result.map((json) => MyWastes.fromJson(json)).toList();
  }

  Future<List<MyItem>> readAllItems() async {
    final db = await instance.database;
    final result = await db.query(MyTable.item);
    return result.map((json) => MyItem.fromJson(json)).toList();
  }

  Future<List<MyCustomer>> readAllCustomers() async {
    final db = await instance.database;
    final result = await db.query(MyTable.customer);
    return result.map((json) => MyCustomer.fromJson(json)).toList();
  }

  Future<List<MySale>> readAllSales() async {
    final db = await instance.database;
    final result = await db.query(MyTable.sale);
    return result.map((json) => MySale.fromJson(json)).toList();
  }

  Future<List<MyItemPriceAtDate>> readAllItemPriceAtDates() async {
    final db = await instance.database;
    final result = await db.query(MyTable.itemPriceAtDate);
    return result.map((json) => MyItemPriceAtDate.fromJson(json)).toList();
  }

  Future<List<MySupplier>> readAllSuppliers() async {
    final db = await instance.database;
    final result = await db.query(MyTable.supplier);
    return result.map((json) => MySupplier.fromJson(json)).toList();
  }

  Future<List<MyCommand>> readAllCommands() async {
    final db = await instance.database;
    final result = await db.query(MyTable.command);
    return result.map((json) => MyCommand.fromJson(json)).toList();
  }

  Future<void> updateItem(MyItem item, MyItem oldItem) async {
    final db = await instance.database;
    db.update(
      MyTable.item,
      item.toJson(),
      where: '${MyTable.itemCodeField} = ?',
      whereArgs: [oldItem.itemCode],
    );
  }

  Future<void> updateCustomer(MyCustomer item, MyCustomer oldCustomer) async {
    final db = await instance.database;
    db.update(
      MyTable.customer,
      item.toJson(),
      where: '${MyTable.customerCodeField} = ?',
      whereArgs: [oldCustomer.customerCode],
    );
  }

  Future<void> updateSupplier(
      MySupplier supplier, MySupplier oldSupplier) async {
    final db = await instance.database;
    db.update(
      MyTable.supplier,
      supplier.toJson(),
      where: '${MyTable.supplierCodeField} = ?',
      whereArgs: [oldSupplier.supplierCode],
    );
  }

  Future<void> delete(String tableName, String rowName, String rowId) async {
    final db = await instance.database;
    db.delete(
      tableName,
      where: '$rowName = ?',
      whereArgs: [rowId],
    );
  }

  Future<void> deleteItemPriceAtDate(String itemCode, String atDate) async {
    final db = await instance.database;
    db.delete(
      MyTable.itemPriceAtDate,
      where: '${MyTable.itemCodeField} = ? AND ${MyTable.atDateField} = ?',
      whereArgs: [itemCode, atDate],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
