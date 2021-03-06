import 'package:flutter/material.dart';
import 'sql.dart';
import 'mytable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySupplier {
  final String? supplierCode;
  final String? supplierName;
  final String? supplierAddress;
  final String? supplierEmail;

  const MySupplier({
    required this.supplierCode,
    required this.supplierName,
    this.supplierAddress = '',
    this.supplierEmail = '',
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
  final String commandCode;
  final String itemCode;
  final double itemQuantity;
  final String providerCode;
  final DateTime commandDate;

  const MyCommand({
    required this.commandCode,
    required this.itemCode,
    required this.itemQuantity,
    this.providerCode = '',
    required this.commandDate,
  });
}

class MyItemPriceAtDate {
  final String? itemCode;
  final DateTime? atDate;
  final double? itemPrice;

  const MyItemPriceAtDate({
    required this.itemCode,
    required this.atDate,
    required this.itemPrice,
  });

  Map<String, Object?> toJson() => {
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.atDateField: atDate ?? '',
        MyTable.itemPriceField: itemPrice ?? '',
      };

  static MyItemPriceAtDate fromJson(Map<String, Object?> json) =>
      MyItemPriceAtDate(
        itemCode: json[MyTable.itemCodeField] as String,
        atDate: json[MyTable.atDateField] as DateTime,
        itemPrice: json[MyTable.itemPriceField] as double,
      );
}

class MyItem {
  final String? itemCode;
  final String? itemDescription;
  final double? itemQuantity;
  final String? itemUnit;
  final String? itemCategory;
  final String? itemQuality;

  const MyItem({
    required this.itemCode,
    this.itemDescription,
    this.itemQuantity,
    this.itemUnit,
    this.itemCategory,
    this.itemQuality,
  });

  Map<String, Object?> toJson() => {
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.itemDescriptionField: itemDescription ?? '',
        MyTable.itemQuantityField: itemQuantity ?? '',
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
    required this.userCode,
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
      customerCode: customer.customerCode,
      customerFirstName: customer.customerFirstName,
      customerLastName: customer.customerLastName,
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
  final String? saleDate;

  const MySale({
    required this.saleCode,
    required this.itemCode,
    this.customerCode,
    required this.itemQuantity,
    required this.saleDate,
  });

  Map<String, Object?> toJson() => {
        MyTable.saleCodeField: saleCode ?? '',
        MyTable.itemCodeField: itemCode ?? '',
        MyTable.customerCodeField: customerCode ?? '',
        MyTable.itemQuantityField: itemQuantity ?? '',
        MyTable.saleDateField: saleDate ?? '',
      };

  static MySale fromJson(Map<String, Object?> json) => MySale(
        saleCode: json[MyTable.saleCodeField] as String,
        itemCode: json[MyTable.itemCodeField] as String,
        customerCode: json[MyTable.customerCodeField] as String,
        itemQuantity: json[MyTable.itemQuantityField] as double,
        saleDate: json[MyTable.saleDateField] as String,
      );

  static MySale copy(MySale sale) {
    return MySale(
      saleCode: sale.saleCode ?? '',
      itemCode: sale.itemCode ?? '',
      customerCode: sale.customerCode ?? '',
      itemQuantity: sale.itemQuantity ?? 0.0,
      saleDate: sale.saleDate ?? '',
    );
  }
}

class DataCenter extends ChangeNotifier {
  String _locale = 'FR';
  List<MyItem> _itemList = [];
  List<MyCustomer> _customerList = [];
  List<MySupplier> _supplierList = [];
  List<MySale> _saleList = [];
  List<MyItemPriceAtDate> _itemPriceAtDateList = [];
  //For settings purpose
  bool _addItemDescriptionField = false;
  bool _addItemQualityField = false;
  bool _addItemUnitField = false;
  bool _addItemCategoryField = false;

  bool _addCustomerAddressField = false;
  bool _addCustomerEmailField = false;

  bool _addSaleCustomerCodeField = false;

  final StockmaxDatabase _database = StockmaxDatabase.instance;

  DataCenter() {
    _init();
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    /* _addItemDescriptionField =
        prefs.getBool('addItemDescriptionField') ?? false;
    _addItemQualityField = prefs.getBool('addItemQualityField') ?? false;
    _addItemUnitField = prefs.getBool('addItemUnitField') ?? false;
    _addItemCategoryField = prefs.getBool('addItemCategoryField') ?? false;

    _addCustomerAddressField =
        prefs.getBool('addCustomerAddressField') ?? false;
    _addCustomerEmailField = prefs.getBool('addCustomerEmailField') ?? false;
    _addSaleCustomerCodeField =
        prefs.getBool('addSaleCustomerCodeField') ?? false;*/
    _locale = prefs.getString('locale') ?? 'FR';
  }

  bool get addCustomerAddressField => _addCustomerAddressField;
  set addCustomerAddressField(bool value) {
    _addCustomerAddressField = value;
    /*if (value) {
      _setUserSettings('addCustomerAddressField', value);
    } else {
      _removeUserSettings('addCustomerAddressField');
    }*/
    notifyListeners();
  }

  bool get addCustomerEmailField => _addCustomerEmailField;
  set addCustomerEmailField(bool value) {
    _addCustomerEmailField = value;
    /*if (value) {
      _setUserSettings('addCustomerEmailField', value);
    } else {
      _removeUserSettings('addCustomerEmailField');
    }*/
    notifyListeners();
  }

  bool get addItemDescriptionField => _addItemDescriptionField;
  set addItemDescriptionField(bool value) {
    _addItemDescriptionField = value;
    /*if (value) {
      _setUserSettings('addItemDescriptionField', value);
    } else {
      _removeUserSettings('addItemDescriptionField');
    }*/
    notifyListeners();
  }

  bool get addItemQualityField => _addItemQualityField;
  set addItemQualityField(bool value) {
    _addItemQualityField = value;
    /*if (value) {
      _setUserSettings('addItemQualityField', value);
    } else {
      _removeUserSettings('addItemQualityField');
    }*/
    notifyListeners();
  }

  bool get addItemUnitField => _addItemUnitField;
  set addItemUnitField(bool value) {
    _addItemUnitField = value;
    /*if (value) {
      _setUserSettings('addItemUnitField', value);
    } else {
      _removeUserSettings('addItemUnitField');
    }*/
    notifyListeners();
  }

  bool get addItemCategoryField => _addItemCategoryField;
  set addItemCategoryField(bool value) {
    _addItemCategoryField = value;
    /*if (value) {
      _setUserSettings('addItemCategoryField', value);
    } else {
      _removeUserSettings('addItemCategoryField');
    }*/
    notifyListeners();
  }

  bool get addSaleCustomerCodeField => _addSaleCustomerCodeField;
  set addSaleCustomerCodeField(bool value) {
    _addSaleCustomerCodeField = value;
    /*if (value) {
      _setUserSettings('addSaleCustomerCodeField', value);
    } else {
      _removeUserSettings('addSaleCustomerCodeField');
    }*/
    notifyListeners();
  }

  double getItemQuantityInStock(String itemCode) {
    double quantity = 0.0;
    for (MyItem element in _itemList) {
      if (element.itemCode == itemCode) {
        quantity = element.itemQuantity!;
      }
    }
    return quantity;
  }

  List<String> getItemCodeList() {
    List<String> itemCodeList = [];
    for (int i = 0; i < _itemList.length; i++) {
      itemCodeList.add(_itemList[i].itemCode!);
    }

    return itemCodeList;
  }

  List<String> getCustomerCodeList() {
    List<String> customerCodeList = [];
    for (int i = 0; i < _customerList.length; i++) {
      customerCodeList.add(_customerList[i].customerCode!);
    }

    return customerCodeList;
  }

  String get locale => _locale;
  set locale(String locale) {
    _locale = locale;
    _setLocale(locale);
    notifyListeners();
  }

  void _setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale);
  }

  void _init() async {
    _itemList = await _database.readAllItems();
    _customerList = await _database.readAllCustomers();
    for (int i = 0; i < _customerList.length; i++) {
      if (_customerList[i].customerCode == MyTable.customerZero) {
        _customerList.remove(_customerList[i]);
      }
    }
    _saleList = await _database.readAllSales();
    _itemPriceAtDateList = await _database.readAllItemPriceAtDates();
    _supplierList = await _database.readAllSuppliers();
    await _loadUserSettings();
    //await _database.listTables();
    notifyListeners();
  }

  /*void _setUserSettings(String userSetting, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(userSetting, value);
  }

  void _removeUserSettings(String userSetting) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userSetting);
  }*/

  void deleteDatabase() async {
    await _database.deleteAllData();
    await GenerateData().generate(_database);
    _init();
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

  void updateItem(int index, MyItem item) async {
    await _database.updateItem(item, _itemList[index]);
    _itemList[index] = item;
    _saleList = await _database.readAllSales();
    _itemPriceAtDateList = await _database.readAllItemPriceAtDates();
    notifyListeners();
  }

  void updateCustomer(int index, MyCustomer item) async {
    await _database.updateCustomer(item, _customerList[index]);
    _customerList[index] = item;
    _saleList = await _database.readAllSales();
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
      for (MyCustomer item in _customerList) {
        if (item.customerCode == rowId) {
          _customerList.remove(item);
          break;
        }
      }
    }

    if (tableName == MyTable.sale) {
      for (MySale item in _saleList) {
        if (item.saleCode == rowId) {
          _saleList.remove(item);
          break;
        }
      }
    }

    if (tableName == MyTable.supplier) {
      for (MySupplier item in _supplierList) {
        if (item.supplierCode == rowId) {
          _supplierList.remove(item);
          break;
        }
      }
    }

    notifyListeners();
    return;
  }

  List<MyItem> get itemList => _itemList;
  List<MyCustomer> get customerList => _customerList;
  List<MySupplier> get supplierList => _supplierList;
  List<MySale> get saleList => _saleList;
  List<MyItemPriceAtDate> get itemPriceAtDateList => _itemPriceAtDateList;

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }
}
