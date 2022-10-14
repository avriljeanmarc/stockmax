import 'package:flutter/material.dart';
//import 'sql.dart';
//import 'model.dart';

/*class GenerateData {
  final List<Map<String, Object?>> itemData = [];
  final List<Map<String, Object?>> customerData = [];
  final List<Map<String, Object?>> supplierData = [];
  //final List<Map<String, Object?>> saleData = [];

  GenerateData() {
    itemData.add({
      MyTable.itemCodeField: 'NGK BKR5EY',
      MyTable.itemQuantityField: 500.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'NGK BKR6EY',
      MyTable.itemQuantityField: 350.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'NGK VPOWER',
      MyTable.itemQuantityField: 150.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'BOSH DOUBLE PLATINUM',
      MyTable.itemQuantityField: 100.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: 'SPARK PLUG',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'B-BOSH',
      MyTable.itemQuantityField: 12.0,
      MyTable.itemUnitField: 'UNIT',
      MyTable.itemCategoryField: 'BATTERY',
      MyTable.itemQualityField: 'NEW',
      MyTable.itemDescriptionField: 'BUILD TO LAST',
    });
    /*itemData.add({
      MyTable.itemCodeField: 'ART-001',
      MyTable.itemDescriptionField: 'Soja',
      MyTable.itemQuantityField: 345.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-002',
      MyTable.itemDescriptionField: 'Olive',
      MyTable.itemQuantityField: 500.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-003',
      MyTable.itemDescriptionField: 'Mazola',
      MyTable.itemQuantityField: 365.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-004',
      MyTable.itemDescriptionField: 'Grisol',
      MyTable.itemQuantityField: 675.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-005',
      MyTable.itemDescriptionField: 'fromage tete de mort',
      MyTable.itemQuantityField: 2255.0,
      MyTable.itemUnitField: 'Boite',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-006',
      MyTable.itemDescriptionField: 'fromage kraft',
      MyTable.itemQuantityField: 344.0,
      MyTable.itemUnitField: 'Boite',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });*/

    customerData.add({
      MyTable.customerCodeField: 'CL000',
      MyTable.customerFirstNameField: 'Jhon',
      MyTable.customerLastNameField: 'PIERRE',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    customerData.add({
      MyTable.customerCodeField: 'CL001',
      MyTable.customerFirstNameField: 'Rudolf',
      MyTable.customerLastNameField: 'DANGUIE',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    customerData.add({
      MyTable.customerCodeField: 'CL002',
      MyTable.customerFirstNameField: 'Pablo',
      MyTable.customerLastNameField: 'ESCOBAR',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    /*saleData.add({
      MyTable.saleCodeField: 'SL001',
      MyTable.itemCodeField: 'ART-001',
      MyTable.customerCodeField: 'CT-001',
      MyTable.itemQuantityField: 10.0,
      MyTable.saleDateField: '4/20/2022',
    });

    saleData.add({
      MyTable.saleCodeField: 'SL002',
      MyTable.itemCodeField: 'ART-006',
      MyTable.customerCodeField: 'CT-002',
      MyTable.itemQuantityField: 5.0,
      MyTable.saleDateField: '4/18/2022',
    });*/

    supplierData.add({
      MyTable.supplierCodeField: 'SP001',
      MyTable.supplierNameField: 'E-POWER S.A.',
      MyTable.supplierAddressField: 'FREE LAND TRADE PARK RUE LISIUS',
      MyTable.supplierEmailField: 'epowerhaiti.com',
    });

    supplierData.add({
      MyTable.supplierCodeField: 'SP786',
      MyTable.supplierNameField: 'CK HARDWARE',
      MyTable.supplierAddressField: 'PARK INDUSTRIEL',
      MyTable.supplierEmailField: 'ckhardware.ht',
    });

    supplierData.add({
      MyTable.supplierCodeField: 'SP345',
      MyTable.supplierNameField: 'EYESMART',
      MyTable.supplierAddressField: 'DELMAS 31 NEXT TO RADIO GINEN',
      MyTable.supplierEmailField: 'eyesmart.com',
    });

    supplierData.add({
      MyTable.supplierCodeField: 'SP002',
      MyTable.supplierNameField: 'UNIPIECE S.A.',
      MyTable.supplierAddressField: 'PV HAITI',
      MyTable.supplierEmailField: 'unipiece.com',
    });
  }

  Future<void> generate(StockmaxDatabase db) async {
    for (Map<String, Object?> item in itemData) {
      await db.insertItem(MyItem.copy(MyItem.fromJson(item)));
    }

    for (Map<String, Object?> item in customerData) {
      await db.insertCustomer(MyCustomer.copy(MyCustomer.fromJson(item)));
    }

    for (Map<String, Object?> item in supplierData) {
      await db.insertSupplier(MySupplier.copy(MySupplier.fromJson(item)));
    }

    /*for (Map<String, Object?> item in saleData) {
      await db.insertSale(MySale.fromJson(item));
    }*/
  }
}*/

class MyTable {
  static const item = 'item';
  static const user = 'user';
  static const customer = 'customer';
  static const sale = 'sale';
  static const supplier = 'supplier';
  static const command = 'command';
  static const itemPriceAtDate = 'ItemPriceAtDate';
  static const wastes = 'wastes';
  static const wastesCodeField = 'wastes_code';
  static const wastesDescriptionField = 'wastes_description';
  static const wastesDateField = 'wastes_date';

  static const customerZero = 'customer_zero';
  static const supplierZero = 'supplier_zero';

  static const itemCodeField = 'item_code';
  static const itemPriceField = 'item_price';
  static const itemDescriptionField = 'item_description';
  static const itemQuantityField = 'item_quantity';
  static const itemUnitField = 'item_unit';
  static const itemCategoryField = 'item_category';
  static const itemQualityField = 'item_quality';

  static const userCodeField = 'user_code';

  static const customerCodeField = 'customer_code';
  static const customerFirstNameField = 'customer_firstName';
  static const customerLastNameField = 'customer_lastName';
  static const customerAddressField = 'customer_address';
  static const customerEmailField = 'customer_email';

  static const saleCodeField = 'sale_code';
  static const saleDateField = 'sale_date';
  static const saleCostField = 'sale_cost';

  static const supplierCodeField = 'supplier_code';
  static const supplierNameField = 'supplier_name';
  static const supplierAddressField = 'supplier_address';
  static const supplierEmailField = 'supplier_email';

  static const atDateField = 'atDate';
  static const commandCodeField = 'command_code';
  static const commandDateField = 'command_date';

  static const settingsAccessCodeField = 'settings_access_code';

  static const frDateFormat = 'dd/MM/yyyy';
  static const enDateFormat = 'MM/dd/yyyy';
  static const saveDateFormat = 'yyyy-MM-dd';

  static const List<String> menuList = [
    'Items',
    'Customers',
    'Suppliers',
  ];

  static const IconData itemIcon = Icons.sell;
  static const IconData customerIcon = Icons.contacts;
  static const IconData saleIcon = Icons.shopping_cart;
  static const IconData supplierIcon = Icons.local_shipping;
  static const IconData customizeDataIcon = Icons.engineering;
  static const IconData commandIcon = Icons.store;
  static const IconData itemPriceAtDateIcon = Icons.attach_money;
  static const IconData WastesIcon = Icons.recycling;

  static const List<String> enMonthsOfYear = [
    'Jan.',
    'Feb.',
    'Mar.',
    'Apr.',
    'May',
    'Jun.',
    'Jul.',
    'Aug.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dec.',
  ];
  static const List<String> frMonthsOfYear = [
    'Jan.',
    'Fev.',
    'Mar.',
    'Avr.',
    'Mai',
    'Jui.',
    'Jul.',
    'Aou.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dec.',
  ];

  static String formatDateToLanguageCode(String languageCode, String date) {
    String _dateWithlanguageCode = date;
    if (languageCode == 'fr') {
      List<String> tab = date.split('-');
      _dateWithlanguageCode = tab[2] +
          ' ' +
          frMonthsOfYear[int.tryParse(tab[1])! - 1] +
          ' ' +
          tab[0];
    }

    if (languageCode == 'en') {
      List<String> tab = date.split('-');
      _dateWithlanguageCode = enMonthsOfYear[int.tryParse(tab[1])! - 1] +
          ' ' +
          tab[2] +
          ', ' +
          tab[0];
    }

    return _dateWithlanguageCode;
  }

  static String getStringByLanguageCode(String str, String languageCode) {
    String _translatedString = str;

    if (str == 'Quantity') {
      if (languageCode == 'fr') {
        _translatedString = 'Quantit\u00E9';
        return _translatedString;
      }
    }
    if (str == 'Unit') {
      if (languageCode == 'fr') {
        _translatedString = 'Unit\u00E9';
        return _translatedString;
      }
    }
    if (str == 'Category') {
      if (languageCode == 'fr') {
        _translatedString = 'Cat\u00E9gorie';
        return _translatedString;
      }
    }
    if (str == 'Quality') {
      if (languageCode == 'fr') {
        _translatedString = 'Qualit\u00E9';
        return _translatedString;
      }
    }
    if (str == 'First name') {
      if (languageCode == 'fr') {
        _translatedString = 'Pr\u00E9nom';
        return _translatedString;
      }
    }
    if (str == 'Last name') {
      if (languageCode == 'fr') {
        _translatedString = 'Nom';
        return _translatedString;
      }
    }
    if (str == 'Address') {
      if (languageCode == 'fr') {
        _translatedString = 'Adresse';
        return _translatedString;
      }
    }

    if (str == 'Item code') {
      if (languageCode == 'fr') {
        _translatedString = 'Code article';
        return _translatedString;
      }
    }
    if (str == 'Customer code') {
      if (languageCode == 'fr') {
        _translatedString = 'Code client';
        return _translatedString;
      }
    }
    if (str == 'E-mail') {
      if (languageCode == 'fr') {
        _translatedString = 'E-mail';
        return _translatedString;
      }
    }
    if (str == 'Date') {
      if (languageCode == 'fr') {
        _translatedString = 'Date';
        return _translatedString;
      }
    }
    if (str == 'Settings') {
      if (languageCode == 'fr') {
        _translatedString = 'Param\u00E8tres';
        return _translatedString;
      }
    }
    if (str == 'French') {
      if (languageCode == 'fr') {
        _translatedString = 'Fran\u00E7ais';
        return _translatedString;
      }
    }
    if (str == 'English') {
      if (languageCode == 'fr') {
        _translatedString = 'Anglais';
        return _translatedString;
      }
    }
    if (str == 'Item') {
      if (languageCode == 'fr') {
        _translatedString = 'Article';
        return _translatedString;
      }
    }
    if (str == 'Items') {
      if (languageCode == 'fr') {
        _translatedString = 'Articles';
        return _translatedString;
      }
    }
    if (str == 'Customer') {
      if (languageCode == 'fr') {
        _translatedString = 'Client';
        return _translatedString;
      }
    }
    if (str == 'Customers') {
      if (languageCode == 'fr') {
        _translatedString = 'Clients';
        return _translatedString;
      }
    }
    if (str == 'Sale') {
      if (languageCode == 'fr') {
        _translatedString = 'Vente';
        return _translatedString;
      }
    }
    if (str == 'Sales') {
      if (languageCode == 'fr') {
        _translatedString = 'Ventes';
        return _translatedString;
      }
    }
    if (str == 'Supplier') {
      if (languageCode == 'fr') {
        _translatedString = 'Fournisseur';
        return _translatedString;
      }
    }
    if (str == 'Suppliers') {
      if (languageCode == 'fr') {
        _translatedString = 'Fournisseurs';
        return _translatedString;
      }
    }
    if (str == 'Stock & Inventory') {
      if (languageCode == 'fr') {
        _translatedString = 'Stock et Inventaire';
        return _translatedString;
      }
    }
    if (str == 'Invalid user code') {
      if (languageCode == 'fr') {
        _translatedString = 'Code utilisateur invalide';
        return _translatedString;
      }
    }
    if (str == 'User code') {
      if (languageCode == 'fr') {
        _translatedString = 'Code utilisateur';
        return _translatedString;
      }
    }
    if (str == 'Log in') {
      if (languageCode == 'fr') {
        _translatedString = 'Connexion';
        return _translatedString;
      }
    }
    if (str == 'List of customers') {
      if (languageCode == 'fr') {
        _translatedString = 'Liste des clients';
        return _translatedString;
      }
    }
    if (str == 'List of items') {
      if (languageCode == 'fr') {
        _translatedString = 'Liste des articles';
        return _translatedString;
      }
    }
    if (str == 'List of sales') {
      if (languageCode == 'fr') {
        _translatedString = 'Liste des ventes';
        return _translatedString;
      }
    }
    if (str == 'New item') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouveau article';
        return _translatedString;
      }
    }
    if (str == 'Item added') {
      if (languageCode == 'fr') {
        _translatedString = 'Article ajout\u00E9';
        return _translatedString;
      }
    }
    if (str == 'Add') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter';
        return _translatedString;
      }
    }
    if (str == 'New customer') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouveau client';
        return _translatedString;
      }
    }
    if (str == 'Customer added') {
      if (languageCode == 'fr') {
        _translatedString = 'Client ajout\u00E9';
        return _translatedString;
      }
    }
    if (str == 'New sale') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouvelle vente';
        return _translatedString;
      }
    }
    if (str == 'Sale added') {
      if (languageCode == 'fr') {
        _translatedString = 'Vente ajout\u00E9e';
        return _translatedString;
      }
    }

    if (str == 'Customize items data') {
      if (languageCode == 'fr') {
        _translatedString = 'Personnaliser les donn\u00E9es des articles';
        return _translatedString;
      }
    }

    if (str == 'Customize customers data') {
      if (languageCode == 'fr') {
        _translatedString = 'Personnaliser les donn\u00E9es des clients';
        return _translatedString;
      }
    }

    if (str == 'Items data') {
      if (languageCode == 'fr') {
        _translatedString = 'Donn\u00E9es des articles';
        return _translatedString;
      }
    }

    if (str == 'Customers data') {
      if (languageCode == 'fr') {
        _translatedString = 'Donn\u00E9es des clients';
        return _translatedString;
      }
    }

    if (str == 'Add description field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ description';
        return _translatedString;
      }
    }

    if (str == 'Add e-mail field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ e-mail';
        return _translatedString;
      }
    }

    if (str == 'Add address field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ adresse';
        return _translatedString;
      }
    }

    if (str == 'Add quality field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ qualit\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Add unit field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ unit\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Add category field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ cat\u00E9gorie';
        return _translatedString;
      }
    }

    if (str == 'Edit') {
      if (languageCode == 'fr') {
        _translatedString = 'Editer';
        return _translatedString;
      }
    }

    if (str == 'Delete') {
      if (languageCode == 'fr') {
        _translatedString = 'Supprimer';
        return _translatedString;
      }
    }

    if (str == 'Field is required') {
      if (languageCode == 'fr') {
        _translatedString = 'Champ obligatoire';
        return _translatedString;
      }
    }

    if (str == 'Duplicated value') {
      if (languageCode == 'fr') {
        _translatedString = 'Valeur dupliqu\u00E9e';
        return _translatedString;
      }
    }

    if (str == 'Value cannot be negative') {
      if (languageCode == 'fr') {
        _translatedString = 'Cette valeur ne peut \u00EAtre n\u00E9gative';
        return _translatedString;
      }
    }

    if (str == 'Are you sure you want to delete') {
      if (languageCode == 'fr') {
        _translatedString = 'Etes-vous s\u00FBr(e) de vouloir supprimer';
        return _translatedString;
      }
    }

    if (str == 'Edit item') {
      if (languageCode == 'fr') {
        _translatedString = 'Modifier article';
        return _translatedString;
      }
    }

    if (str == 'Item edited') {
      if (languageCode == 'fr') {
        _translatedString = 'Article modifi\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Customize sales data') {
      if (languageCode == 'fr') {
        _translatedString = 'Personnaliser les donn\u00E9es des ventes';
        return _translatedString;
      }
    }

    if (str == 'Customer edited') {
      if (languageCode == 'fr') {
        _translatedString = 'Client modifi\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Edit customer') {
      if (languageCode == 'fr') {
        _translatedString = 'Modifier client';
        return _translatedString;
      }
    }

    if (str == 'Sales data') {
      if (languageCode == 'fr') {
        _translatedString = 'Donn\u00E9es des ventes';
        return _translatedString;
      }
    }

    if (str == 'Add customer field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ client';
        return _translatedString;
      }
    }

    if (str == 'List of suppliers') {
      if (languageCode == 'fr') {
        _translatedString = 'Liste des fournisseurs';
        return _translatedString;
      }
    }

    if (str == 'Supplier added') {
      if (languageCode == 'fr') {
        _translatedString = 'Fournisseur ajout\u00E9';
        return _translatedString;
      }
    }

    if (str == 'New supplier') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouveau fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier name') {
      if (languageCode == 'fr') {
        _translatedString = 'Nom fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier address') {
      if (languageCode == 'fr') {
        _translatedString = 'Adresse fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier e-mail') {
      if (languageCode == 'fr') {
        _translatedString = 'E-mail fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Insufficient stock') {
      if (languageCode == 'fr') {
        _translatedString = 'Stock insuffisant';
        return _translatedString;
      }
    }

    if (str == 'Update stock') {
      if (languageCode == 'fr') {
        _translatedString = 'Actualiser stock';
        return _translatedString;
      }
    }

    if (str == 'Current quantity') {
      if (languageCode == 'fr') {
        _translatedString = 'Quantit\u00E9 actuelle';
        return _translatedString;
      }
    }

    if (str == 'New quantity') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouvelle quantit\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Final quantity') {
      if (languageCode == 'fr') {
        _translatedString = 'Quantit\u00E9 finale';
        return _translatedString;
      }
    }

    if (str == 'Item updated') {
      if (languageCode == 'fr') {
        _translatedString = 'Article actualis\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Commands') {
      if (languageCode == 'fr') {
        _translatedString = 'Commandes';
        return _translatedString;
      }
    }

    if (str == 'List of commands') {
      if (languageCode == 'fr') {
        _translatedString = 'Liste des commandes';
        return _translatedString;
      }
    }

    if (str == 'Command added') {
      if (languageCode == 'fr') {
        _translatedString = 'Commande ajout\u00E9e';
        return _translatedString;
      }
    }

    if (str == 'New command') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouvelle commande';
        return _translatedString;
      }
    }

    if (str == 'Add supplier code field') {
      if (languageCode == 'fr') {
        _translatedString = 'Ajouter le champ code du fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier code') {
      if (languageCode == 'fr') {
        _translatedString = 'Code fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Total cost') {
      if (languageCode == 'fr') {
        _translatedString = 'Co\u00FBt total';
        return _translatedString;
      }
    }

    if (str == 'Edit price') {
      if (languageCode == 'fr') {
        _translatedString = 'Editer prix';
        return _translatedString;
      }
    }

    if (str == 'Price') {
      if (languageCode == 'fr') {
        _translatedString = 'Prix';
        return _translatedString;
      }
    }

    if (str == 'Price edited') {
      if (languageCode == 'fr') {
        _translatedString = 'Prix modifi\u00E9';
        return _translatedString;
      }
    }

    if (str == 'View prices history') {
      if (languageCode == 'fr') {
        _translatedString = 'Voir l\'historicit\u00E9 des prix';
        return _translatedString;
      }
    }

    if (str == 'Prices history') {
      if (languageCode == 'fr') {
        _translatedString = 'Historicit\u00E9 des prix';
        return _translatedString;
      }
    }

    if (str == 'Supplier edited') {
      if (languageCode == 'fr') {
        _translatedString = 'Fournisseur modifi\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Import excel sheet') {
      if (languageCode == 'fr') {
        _translatedString = 'Importer une feuille excel';
        return _translatedString;
      }
    }

    if (str == 'Export excel sheet') {
      if (languageCode == 'fr') {
        _translatedString = 'Exporter une feuille excel';
        return _translatedString;
      }
    }

    if (str == 'Wastes') {
      if (languageCode == 'fr') {
        _translatedString = 'Pertes';
        return _translatedString;
      }
    }

    if (str == 'List of wastes') {
      if (languageCode == 'fr') {
        _translatedString = 'Liste des pertes';
        return _translatedString;
      }
    }

    if (str == 'Waste added') {
      if (languageCode == 'fr') {
        _translatedString = 'Perte ajout\u00E9e';
        return _translatedString;
      }
    }

    if (str == 'New waste') {
      if (languageCode == 'fr') {
        _translatedString = 'Nouvelle perte';
        return _translatedString;
      }
    }
    return _translatedString;

//StatefulBuilder(builder: (context, setState){})
  }
}
