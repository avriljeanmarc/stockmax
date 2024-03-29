import 'package:flutter/material.dart';
import 'sql.dart';
import 'mytable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWastes {
  final String? wastesCode;
  final String? itemCode;
  final double? itemQuantity;
  final String? wastesDate;
  final String? wastesDescription;

  const MyWastes({
    this.wastesCode,
    this.itemCode,
    this.itemQuantity,
    this.wastesDate,
    this.wastesDescription,
  });

  Map<String, Object?> toJson() => {
        MyTable.wastesCodeField: wastesCode ?? '',
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.itemQuantityField: itemQuantity ?? 0.0,
        MyTable.wastesDateField: wastesDate ?? '',
        MyTable.wastesDescriptionField: wastesDescription ?? '',
      };

  static MyWastes fromJson(Map<String, Object?> json) => MyWastes(
        wastesCode: json[MyTable.wastesCodeField] as String,
        itemCode: json[MyTable.itemCodeField] as String,
        itemQuantity: json[MyTable.itemQuantityField] as double,
        wastesDate: json[MyTable.wastesDateField] as String,
        wastesDescription: json[MyTable.wastesDescriptionField] as String,
      );

  static MyWastes copy(MyWastes wastes) {
    return MyWastes(
      wastesCode: wastes.wastesCode ?? '',
      itemCode: wastes.itemCode ?? '',
      itemQuantity: wastes.itemQuantity ?? 0.0,
      wastesDate: wastes.wastesDate ?? '',
      wastesDescription: wastes.wastesDescription ?? '',
    );
  }
}

class MySupplier {
  final String? supplierCode;
  final String? supplierName;
  final String? supplierAddress;
  final String? supplierEmail;

  const MySupplier({
    this.supplierCode,
    this.supplierName,
    this.supplierAddress,
    this.supplierEmail,
  });

  Map<String, Object?> toJson() => {
        MyTable.supplierCodeField: supplierCode ?? '',
        MyTable.supplierNameField: supplierName ?? '',
        MyTable.supplierAddressField: supplierAddress ?? '',
        MyTable.supplierEmailField: supplierEmail ?? '',
      };

  static MySupplier fromJson(Map<String, Object?> json) => MySupplier(
        supplierCode: json[MyTable.supplierCodeField] as String,
        supplierName: json[MyTable.supplierNameField] as String,
        supplierAddress: json[MyTable.supplierAddressField] as String,
        supplierEmail: json[MyTable.supplierEmailField] as String,
      );

  static MySupplier copy(MySupplier supplier) {
    return MySupplier(
      supplierCode: supplier.supplierCode ?? '',
      supplierName: supplier.supplierName ?? '',
      supplierAddress: supplier.supplierAddress ?? '',
      supplierEmail: supplier.supplierEmail ?? '',
    );
  }
}

class MyCommand {
  final String? commandCode;
  final String? itemCode;
  final double? itemQuantity;
  final String? supplierCode;
  final String? commandDate;

  const MyCommand({
    this.commandCode,
    this.itemCode,
    this.itemQuantity,
    this.supplierCode,
    this.commandDate,
  });

  Map<String, Object?> toJson() => {
        MyTable.commandCodeField: commandCode ?? '',
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.itemQuantityField: itemQuantity ?? 0.0,
        MyTable.supplierCodeField: supplierCode ?? '',
        MyTable.commandDateField: commandDate ?? '',
      };

  static MyCommand fromJson(Map<String, Object?> json) => MyCommand(
        commandCode: json[MyTable.commandCodeField] as String,
        itemCode: json[MyTable.itemCodeField] as String,
        itemQuantity: json[MyTable.itemQuantityField] as double,
        supplierCode: json[MyTable.supplierCodeField] as String,
        commandDate: json[MyTable.commandDateField] as String,
      );

  static MyCommand copy(MyCommand command) {
    return MyCommand(
      commandCode: command.commandCode ?? '',
      itemCode: command.itemCode ?? '',
      itemQuantity: command.itemQuantity ?? 0.0,
      supplierCode: command.supplierCode ?? '',
      commandDate: command.commandDate ?? '',
    );
  }
}

class MyItemPriceAtDate {
  final String? itemCode;
  final String? atDate;
  final double? itemPrice;

  const MyItemPriceAtDate({
    this.itemCode,
    this.atDate,
    this.itemPrice,
  });

  Map<String, Object?> toJson() => {
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.atDateField: atDate ?? '',
        MyTable.itemPriceField: itemPrice ?? 0.0,
      };

  static MyItemPriceAtDate fromJson(Map<String, Object?> json) =>
      MyItemPriceAtDate(
        itemCode: json[MyTable.itemCodeField] as String,
        atDate: json[MyTable.atDateField] as String,
        itemPrice: json[MyTable.itemPriceField] as double,
      );

  static MyItemPriceAtDate copy(MyItemPriceAtDate price) {
    return MyItemPriceAtDate(
      itemCode: price.itemCode ?? '',
      atDate: price.atDate ?? '',
      itemPrice: price.itemPrice ?? 0.0,
    );
  }
}

class MyItem {
  final String? itemCode;
  final String? itemDescription;
  final double? itemQuantity;
  final String? itemUnit;
  final String? itemCategory;
  final String? itemQuality;

  const MyItem({
    this.itemCode,
    this.itemDescription,
    this.itemQuantity,
    this.itemUnit,
    this.itemCategory,
    this.itemQuality,
  });

  Map<String, Object?> toJson() => {
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.itemDescriptionField: itemDescription ?? '',
        MyTable.itemQuantityField: itemQuantity ?? 0.0,
        MyTable.itemUnitField: itemUnit ?? '',
        MyTable.itemCategoryField: itemCategory ?? '',
        MyTable.itemQualityField: itemQuality ?? '',
      };

  static MyItem fromJson(Map<String, Object?> json) => MyItem(
        itemCode: json[MyTable.itemCodeField] as String,
        itemDescription: json[MyTable.itemDescriptionField] as String,
        itemQuantity: json[MyTable.itemQuantityField] as double,
        itemUnit: json[MyTable.itemUnitField] as String,
        itemCategory: json[MyTable.itemCategoryField] as String,
        itemQuality: json[MyTable.itemQualityField] as String,
      );

  static MyItem copy(MyItem item) {
    return MyItem(
      itemCode: item.itemCode ?? '',
      itemCategory: item.itemCategory ?? '',
      itemDescription: item.itemDescription ?? '',
      itemQuality: item.itemQuality ?? '',
      itemQuantity: item.itemQuantity ?? 0.0,
      itemUnit: item.itemUnit ?? '',
    );
  }
}

class MyUser {
  final String? userCode;
  final String? settingsAccessCode;

  const MyUser({
    this.userCode,
    this.settingsAccessCode,
  });

  Map<String, Object?> toJson() => {
        MyTable.userCodeField: userCode ?? '',
        MyTable.settingsAccessCodeField: settingsAccessCode ?? '',
      };

  static MyUser fromJson(Map<String, Object?> json) => MyUser(
        userCode: json[MyTable.userCodeField] as String,
        settingsAccessCode: json[MyTable.settingsAccessCodeField] as String,
      );
}

class MyCustomer {
  final String? customerCode;
  final String? customerFirstName;
  final String? customerLastName;
  final String? customerAddress;
  final String? customerEmail;

  const MyCustomer({
    this.customerCode,
    this.customerFirstName,
    this.customerLastName,
    this.customerAddress,
    this.customerEmail,
  });

  Map<String, Object?> toJson() => {
        MyTable.customerCodeField: customerCode ?? '',
        MyTable.customerFirstNameField: customerFirstName ?? '',
        MyTable.customerLastNameField: customerLastName ?? '',
        MyTable.customerAddressField: customerAddress ?? '',
        MyTable.customerEmailField: customerEmail ?? '',
      };

  static MyCustomer fromJson(Map<String, Object?> json) => MyCustomer(
        customerCode: json[MyTable.customerCodeField] as String,
        customerFirstName: json[MyTable.customerFirstNameField] as String,
        customerLastName: json[MyTable.customerLastNameField] as String,
        customerAddress: json[MyTable.customerAddressField] as String,
        customerEmail: json[MyTable.customerEmailField] as String,
      );

  static MyCustomer copy(MyCustomer customer) {
    return MyCustomer(
      customerCode: customer.customerCode ?? '',
      customerFirstName: customer.customerFirstName ?? '',
      customerLastName: customer.customerLastName ?? '',
      customerAddress: customer.customerAddress ?? '',
      customerEmail: customer.customerEmail ?? '',
    );
  }
}

class MySale {
  final String? saleCode;
  final String? itemCode;
  final String? customerCode;
  final double? itemQuantity;
  final double? saleCost;
  final String? saleDate;

  const MySale({
    this.saleCode,
    this.itemCode,
    this.customerCode,
    this.itemQuantity,
    this.saleCost,
    this.saleDate,
  });

  Map<String, Object?> toJson() => {
        MyTable.saleCodeField: saleCode ?? '',
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.customerCodeField: customerCode ?? '',
        MyTable.itemQuantityField: itemQuantity ?? 0.0,
        MyTable.saleCostField: saleCost ?? 0.0,
        MyTable.saleDateField: saleDate ?? '',
      };

  static MySale fromJson(Map<String, Object?> json) => MySale(
        saleCode: json[MyTable.saleCodeField] as String,
        itemCode: json[MyTable.itemCodeField] as String,
        customerCode: json[MyTable.customerCodeField] as String,
        itemQuantity: json[MyTable.itemQuantityField] as double,
        saleCost: json[MyTable.saleCostField] as double,
        saleDate: json[MyTable.saleDateField] as String,
      );

  static MySale copy(MySale sale) {
    return MySale(
      saleCode: sale.saleCode ?? '',
      itemCode: sale.itemCode ?? '',
      customerCode: sale.customerCode ?? '',
      itemQuantity: sale.itemQuantity ?? 0.0,
      saleCost: sale.saleCost ?? 0.0,
      saleDate: sale.saleDate ?? '',
    );
  }
}

class DataCenter extends ChangeNotifier {
  String _languageCode = 'fr';
  List<MyItem> _itemList = [];
  List<MyCustomer> _customerList = [];
  List<MySupplier> _supplierList = [];
  List<MySale> _saleList = [];
  List<MyItemPriceAtDate> _itemPriceAtDateList = [];
  List<MyCommand> _commandList = [];
  List<MyWastes> _wastesList = [];

  final int lessStockValue = 100;
  String _flutterError = '';

  final StockmaxDatabase _database = StockmaxDatabase.instance;

  DataCenter() {
    _init();
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('languageCode') ?? 'fr';
  }

  MyItem? getItemByCode(String itemCode) {
    MyItem? item;
    for (MyItem element in _itemList) {
      if (element.itemCode == itemCode) {
        item = element;
      }
    }
    return item;
  }

  String get languageCode => _languageCode;
  set languageCode(String languageCode) {
    _languageCode = languageCode;

    _setLanguageCode(languageCode);
    notifyListeners();
  }

  String get flutterError => _flutterError;
  set flutterError(String flutterError) {
    _flutterError = flutterError;
    notifyListeners();
  }

  void _setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', languageCode);
  }

  void _init() async {
    _itemList = await _database.readAllItems();
    _customerList = await _database.readAllCustomers();
    for (int i = 0; i < _customerList.length; i++) {
      if (_customerList[i].customerCode == MyTable.customerZero) {
        _customerList.remove(_customerList[i]);
        break;
      }
    }
    _saleList = await _database.readAllSales();
    _itemPriceAtDateList = await _database.readAllItemPriceAtDates();
    _supplierList = await _database.readAllSuppliers();
    for (int i = 0; i < _supplierList.length; i++) {
      if (_supplierList[i].supplierCode == MyTable.supplierZero) {
        _supplierList.remove(_supplierList[i]);
        break;
      }
    }
    _commandList = await _database.readAllCommands();
    _wastesList = await _database.readAllWastes();
    await _loadUserSettings();
    //await _database.listTables();
    notifyListeners();
  }

  void deleteDatabase() async {
    await _database.deleteAllData();
    //await GenerateData().generate(_database);
    _init();
  }

  void insertWastes(MyWastes wastes) async {
    await _database.insertWastes(wastes);
    _wastesList.add(wastes);
    notifyListeners();
  }

  void insertItem(MyItem item) async {
    await _database.insertItem(item);
    _itemList.add(item);
    notifyListeners();
  }

  void insertCustomer(MyCustomer customer) async {
    await _database.insertCustomer(customer);
    _customerList.add(customer);
    notifyListeners();
  }

  void insertSale(MySale sale) async {
    await _database.insertSale(sale);
    _saleList.add(sale);
    notifyListeners();
  }

  void insertSupplier(MySupplier supplier) async {
    await _database.insertSupplier(supplier);
    _supplierList.add(supplier);
    notifyListeners();
  }

  void insertCommand(MyCommand command) async {
    await _database.insertCommand(command);
    _commandList.add(command);
    notifyListeners();
  }

  void insertItemPriceAtDate(MyItemPriceAtDate price) async {
    await _database.insertItemPriceAtDate(price);
    _itemPriceAtDateList.add(price);
    notifyListeners();
  }

  void updateItem(MyItem item,
      {int index = -1500, String itemCode = ''}) async {
    int thisindex = index;
    if (itemCode.isNotEmpty) {
      for (int i = 0; i < _itemList.length; i++) {
        if (_itemList[i].itemCode == itemCode) {
          thisindex = i;
          break;
        }
      }
    }

    await _database.updateItem(item, _itemList[thisindex]);
    _itemList[thisindex] = item;

    _saleList = await _database.readAllSales();
    _itemPriceAtDateList = await _database.readAllItemPriceAtDates();
    _wastesList = await _database.readAllWastes();
    notifyListeners();
  }

  void updateCustomer(int index, MyCustomer item) async {
    await _database.updateCustomer(item, _customerList[index]);
    _customerList[index] = item;
    _saleList = await _database.readAllSales();
    notifyListeners();
  }

  void updateSupplier(int index, MySupplier supplier) async {
    await _database.updateSupplier(supplier, _supplierList[index]);
    _supplierList[index] = supplier;
    _commandList = await _database.readAllCommands();
    notifyListeners();
  }

  void deleteRow(String tableName, String rowName, String rowId) async {
    await _database.delete(tableName, rowName, rowId);

    if (tableName == MyTable.item) {
      for (MyItem item in _itemList) {
        if (item.itemCode == rowId) {
          _itemList.remove(item);
          break;
        }
      }
    }

    if (tableName == MyTable.customer) {
      for (MyCustomer customer in _customerList) {
        if (customer.customerCode == rowId) {
          _customerList.remove(customer);
          break;
        }
      }
    }

    if (tableName == MyTable.sale) {
      for (MySale sale in _saleList) {
        if (sale.saleCode == rowId) {
          _saleList.remove(sale);
          break;
        }
      }
    }

    if (tableName == MyTable.supplier) {
      for (MySupplier supplier in _supplierList) {
        if (supplier.supplierCode == rowId) {
          _supplierList.remove(supplier);
          break;
        }
      }
    }

    if (tableName == MyTable.command) {
      for (MyCommand command in _commandList) {
        if (command.commandCode == rowId) {
          _commandList.remove(command);
          break;
        }
      }
    }

    notifyListeners();
  }

  void deleteItemPriceAtDate(String itemCode, String atDate) async {
    await _database.deleteItemPriceAtDate(itemCode, atDate);
    for (MyItemPriceAtDate price in _itemPriceAtDateList) {
      if (price.itemCode == itemCode && price.atDate == atDate) {
        _itemPriceAtDateList.remove(price);
        break;
      }
    }

    notifyListeners();
  }

  List<MyCommand> get commandList => _commandList;
  List<MyItem> get itemList => _itemList;
  List<MyCustomer> get customerList => _customerList;
  List<MySupplier> get supplierList => _supplierList;
  List<MySale> get saleList => _saleList;
  List<MyItemPriceAtDate> get itemPriceAtDateList => _itemPriceAtDateList;
  List<MyWastes> get wastesList => _wastesList;

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }
}
