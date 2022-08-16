import 'package:flutter/material.dart';
import 'sql.dart';
import 'data_model.dart';

class GenerateData {
  final List<Map<String, Object?>> itemData = [];
  final List<Map<String, Object?>> customerData = [];
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
      MyTable.itemCodeField: 'BUSH DOUBLE PLATINUM',
      MyTable.itemQuantityField: 100.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
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
      MyTable.itemDescriptionField: 'Fromage tete de mort',
      MyTable.itemQuantityField: 2255.0,
      MyTable.itemUnitField: 'Boite',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-006',
      MyTable.itemDescriptionField: 'Fromage kraft',
      MyTable.itemQuantityField: 344.0,
      MyTable.itemUnitField: 'Boite',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });*/

    customerData.add({
      MyTable.customerCodeField: 'CLIENT-000',
      MyTable.customerFirstNameField: 'Jhon',
      MyTable.customerLastNameField: 'PIERRE',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    customerData.add({
      MyTable.customerCodeField: 'CLIENT-001',
      MyTable.customerFirstNameField: 'Rudolf',
      MyTable.customerLastNameField: 'DANGUIE',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    customerData.add({
      MyTable.customerCodeField: 'CLIENT-002',
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
  }

  Future<void> generate(StockmaxDatabase db) async {
    for (Map<String, Object?> item in itemData) {
      await db.insertItem(MyItem.copy(MyItem.fromJson(item)));
    }

    for (Map<String, Object?> item in customerData) {
      await db.insertCustomer(MyCustomer.copy(MyCustomer.fromJson(item)));
    }

    /*for (Map<String, Object?> item in saleData) {
      await db.insertSale(MySale.fromJson(item));
    }*/
  }
}

class MyTable {
  static const item = 'item';
  static const user = 'user';
  static const customer = 'customer';
  static const sale = 'sale';
  static const supplier = 'supplier';
  static const command = 'command';
  static const itemPriceAtDate = 'ItemPriceAtDate';

  static const customerZero = 'customer_zero';

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

  static const supplierCodeField = 'supplier_code';
  static const supplierNameField = 'supplier_name';
  static const supplierAddressField = 'supplier_address';
  static const supplierEmailField = 'supplier_email';

  static const atDateField = 'atDate';
  static const commandCodeField = 'command_code';
  static const commandDateField = 'command_date';

  static const settingsAccessCodeField = 'settings_access_code';
  static const IconData itemIcon = Icons.sell;
  static const IconData customerIcon = Icons.contacts;
  static const IconData saleIcon = Icons.shopping_cart;
  static const IconData supplierIcon = Icons.local_shipping;
  static const IconData customizeDataIcon = Icons.engineering;
  static const IconData commandIcon = Icons.engineering;

  static String formatDateToLocale(String locale, String date) {
    String _dateWithLocale = date;
    if (locale == 'FR') {
      List<String> tab = date.split('/');
      _dateWithLocale = tab[1] + '/' + tab[0] + '/' + tab[2];
    }

    return _dateWithLocale;
  }

  static String getStringByLocale(String str, String locale) {
    String _translatedString = str;

    if (str == 'Quantity') {
      if (locale == 'FR') {
        _translatedString = 'Quantit\u00E9';
        return _translatedString;
      }
    }
    if (str == 'Unit') {
      if (locale == 'FR') {
        _translatedString = 'Unit\u00E9';
        return _translatedString;
      }
    }
    if (str == 'Category') {
      if (locale == 'FR') {
        _translatedString = 'Cat\u00E9gorie';
        return _translatedString;
      }
    }
    if (str == 'Quality') {
      if (locale == 'FR') {
        _translatedString = 'Qualit\u00E9';
        return _translatedString;
      }
    }
    if (str == 'First name') {
      if (locale == 'FR') {
        _translatedString = 'Pr\u00E9nom';
        return _translatedString;
      }
    }
    if (str == 'Last name') {
      if (locale == 'FR') {
        _translatedString = 'Nom';
        return _translatedString;
      }
    }
    if (str == 'Address') {
      if (locale == 'FR') {
        _translatedString = 'Adresse';
        return _translatedString;
      }
    }

    if (str == 'Item code') {
      if (locale == 'FR') {
        _translatedString = 'Code article';
        return _translatedString;
      }
    }
    if (str == 'Customer code') {
      if (locale == 'FR') {
        _translatedString = 'Code client';
        return _translatedString;
      }
    }
    if (str == 'E-mail') {
      if (locale == 'FR') {
        _translatedString = 'E-mail';
        return _translatedString;
      }
    }
    if (str == 'Date') {
      if (locale == 'FR') {
        _translatedString = 'Date';
        return _translatedString;
      }
    }
    if (str == 'Settings') {
      if (locale == 'FR') {
        _translatedString = 'Param\u00E8tres';
        return _translatedString;
      }
    }
    if (str == 'French') {
      if (locale == 'FR') {
        _translatedString = 'Fran\u00E7ais';
        return _translatedString;
      }
    }
    if (str == 'English') {
      if (locale == 'FR') {
        _translatedString = 'Anglais';
        return _translatedString;
      }
    }
    if (str == 'Item') {
      if (locale == 'FR') {
        _translatedString = 'Article';
        return _translatedString;
      }
    }
    if (str == 'Items') {
      if (locale == 'FR') {
        _translatedString = 'Articles';
        return _translatedString;
      }
    }
    if (str == 'Customer') {
      if (locale == 'FR') {
        _translatedString = 'Client';
        return _translatedString;
      }
    }
    if (str == 'Customers') {
      if (locale == 'FR') {
        _translatedString = 'Clients';
        return _translatedString;
      }
    }
    if (str == 'Sale') {
      if (locale == 'FR') {
        _translatedString = 'Vente';
        return _translatedString;
      }
    }
    if (str == 'Sales') {
      if (locale == 'FR') {
        _translatedString = 'Ventes';
        return _translatedString;
      }
    }
    if (str == 'Supplier') {
      if (locale == 'FR') {
        _translatedString = 'Fournisseur';
        return _translatedString;
      }
    }
    if (str == 'Suppliers') {
      if (locale == 'FR') {
        _translatedString = 'Fournisseurs';
        return _translatedString;
      }
    }
    if (str == 'Stock & inventory') {
      if (locale == 'FR') {
        _translatedString = 'Stock et inventaire';
        return _translatedString;
      }
    }
    if (str == 'Invalid user code') {
      if (locale == 'FR') {
        _translatedString = 'Code utilisateur invalide';
        return _translatedString;
      }
    }
    if (str == 'User code') {
      if (locale == 'FR') {
        _translatedString = 'Code utilisateur';
        return _translatedString;
      }
    }
    if (str == 'Log in') {
      if (locale == 'FR') {
        _translatedString = 'Connexion';
        return _translatedString;
      }
    }
    if (str == 'List of customers') {
      if (locale == 'FR') {
        _translatedString = 'Liste des clients';
        return _translatedString;
      }
    }
    if (str == 'List of items') {
      if (locale == 'FR') {
        _translatedString = 'Liste des articles';
        return _translatedString;
      }
    }
    if (str == 'List of sales') {
      if (locale == 'FR') {
        _translatedString = 'Liste des ventes';
        return _translatedString;
      }
    }
    if (str == 'New item') {
      if (locale == 'FR') {
        _translatedString = 'Nouveau article';
        return _translatedString;
      }
    }
    if (str == 'Item added') {
      if (locale == 'FR') {
        _translatedString = 'Article ajout\u00E9';
        return _translatedString;
      }
    }
    if (str == 'Add') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter';
        return _translatedString;
      }
    }
    if (str == 'New customer') {
      if (locale == 'FR') {
        _translatedString = 'Nouveau client';
        return _translatedString;
      }
    }
    if (str == 'Customer added') {
      if (locale == 'FR') {
        _translatedString = 'Client ajout\u00E9';
        return _translatedString;
      }
    }
    if (str == 'New sale') {
      if (locale == 'FR') {
        _translatedString = 'Nouvelle vente';
        return _translatedString;
      }
    }
    if (str == 'Sale added') {
      if (locale == 'FR') {
        _translatedString = 'Vente ajout\u00E9e';
        return _translatedString;
      }
    }

    if (str == 'Customize items data') {
      if (locale == 'FR') {
        _translatedString = 'Personnaliser les donn\u00E9es des articles';
        return _translatedString;
      }
    }

    if (str == 'Customize customers data') {
      if (locale == 'FR') {
        _translatedString = 'Personnaliser les donn\u00E9es des clients';
        return _translatedString;
      }
    }

    if (str == 'Items data') {
      if (locale == 'FR') {
        _translatedString = 'Donn\u00E9es des articles';
        return _translatedString;
      }
    }

    if (str == 'Customers data') {
      if (locale == 'FR') {
        _translatedString = 'Donn\u00E9es des clients';
        return _translatedString;
      }
    }

    if (str == 'Add description field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ description';
        return _translatedString;
      }
    }

    if (str == 'Add e-mail field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ e-mail';
        return _translatedString;
      }
    }

    if (str == 'Add address field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ adresse';
        return _translatedString;
      }
    }

    if (str == 'Add quality field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ qualit\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Add unit field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ unit\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Add category field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ cat\u00E9gorie';
        return _translatedString;
      }
    }

    if (str == 'Edit') {
      if (locale == 'FR') {
        _translatedString = 'Editer';
        return _translatedString;
      }
    }

    if (str == 'Delete') {
      if (locale == 'FR') {
        _translatedString = 'Supprimer';
        return _translatedString;
      }
    }

    if (str == 'Field is required') {
      if (locale == 'FR') {
        _translatedString = 'Champ obligatoire';
        return _translatedString;
      }
    }

    if (str == 'Duplicated value') {
      if (locale == 'FR') {
        _translatedString = 'Valeur dupliqu\u00E9e';
        return _translatedString;
      }
    }

    if (str == 'Value cannot be negative') {
      if (locale == 'FR') {
        _translatedString = 'Cette valeur ne peut \u00EAtre n\u00E9gative';
        return _translatedString;
      }
    }

    if (str == 'Are you sure you want to delete') {
      if (locale == 'FR') {
        _translatedString = 'Etes-vous s\u00FBr(e) de vouloir supprimer';
        return _translatedString;
      }
    }

    if (str == 'Edit item') {
      if (locale == 'FR') {
        _translatedString = 'Modifier article';
        return _translatedString;
      }
    }

    if (str == 'Item edited') {
      if (locale == 'FR') {
        _translatedString = 'Article modifi\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Customize sales data') {
      if (locale == 'FR') {
        _translatedString = 'Personnaliser les donn\u00E9es des ventes';
        return _translatedString;
      }
    }

    if (str == 'Customer edited') {
      if (locale == 'FR') {
        _translatedString = 'Client modifi\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Edit customer') {
      if (locale == 'FR') {
        _translatedString = 'Modifier client';
        return _translatedString;
      }
    }

    if (str == 'Sales data') {
      if (locale == 'FR') {
        _translatedString = 'Donn\u00E9es des ventes';
        return _translatedString;
      }
    }

    if (str == 'Add customer field') {
      if (locale == 'FR') {
        _translatedString = 'Ajouter le champ client';
        return _translatedString;
      }
    }

    if (str == 'List of suppliers') {
      if (locale == 'FR') {
        _translatedString = 'Liste des fournisseurs';
        return _translatedString;
      }
    }

    if (str == 'Supplier added') {
      if (locale == 'FR') {
        _translatedString = 'Fournisseur ajout\u00E9';
        return _translatedString;
      }
    }

    if (str == 'New supplier') {
      if (locale == 'FR') {
        _translatedString = 'Nouveau fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier name') {
      if (locale == 'FR') {
        _translatedString = 'Nom fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier address') {
      if (locale == 'FR') {
        _translatedString = 'Adresse fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Supplier e-mail') {
      if (locale == 'FR') {
        _translatedString = 'E-mail fournisseur';
        return _translatedString;
      }
    }

    if (str == 'Insufficient stock') {
      if (locale == 'FR') {
        _translatedString = 'Stock insuffisant';
        return _translatedString;
      }
    }

    if (str == 'Update stock') {
      if (locale == 'FR') {
        _translatedString = 'Actualiser stock';
        return _translatedString;
      }
    }

    if (str == 'Current quantity') {
      if (locale == 'FR') {
        _translatedString = 'Quantit\u00E9 actuelle';
        return _translatedString;
      }
    }

    if (str == 'New quantity') {
      if (locale == 'FR') {
        _translatedString = 'Nouvelle quantit\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Final quantity') {
      if (locale == 'FR') {
        _translatedString = 'Quantit\u00E9 finale';
        return _translatedString;
      }
    }

    if (str == 'Item updated') {
      if (locale == 'FR') {
        _translatedString = 'Article actualis\u00E9';
        return _translatedString;
      }
    }

    if (str == 'Commands') {
      if (locale == 'FR') {
        _translatedString = 'Commandes';
        return _translatedString;
      }
    }

    if (str == 'List of commands') {
      if (locale == 'FR') {
        _translatedString = 'Liste des commandes';
        return _translatedString;
      }
    }

    return _translatedString;

//StatefulBuilder(builder: (context, setState){})
  }
}
