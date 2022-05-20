import 'package:flutter/material.dart';
import 'data_model.dart';
import 'package:provider/provider.dart';
import 'custom_material.dart';
import 'mytable.dart';

class ItemSettings extends StatelessWidget {
  const ItemSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showFloatingButton: false,
      showActionsButton: true,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeWidget(),
            ),
          ),
          icon: const Icon(
            Icons.home,
          ),
        ),
      ],
      appBarTitle: Text(MyTable.getStringByLocale(
          'Items data', context.read<DataCenter>().locale)),
      child: Column(
        children: [
          SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add description field', context.read<DataCenter>().locale)),
            value: context.watch<DataCenter>().addItemDescriptionField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addItemDescriptionField = value,
          ),
          SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add quality field', context.read<DataCenter>().locale)),
            value: context.read<DataCenter>().addItemQualityField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addItemQualityField = value,
          ),
          SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add unit field', context.read<DataCenter>().locale)),
            value: context.read<DataCenter>().addItemUnitField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addItemUnitField = value,
          ),
          SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add category field', context.read<DataCenter>().locale)),
            value: context.read<DataCenter>().addItemCategoryField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addItemCategoryField = value,
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MyItem> items = context.watch<DataCenter>().itemList;
    return MyScaffold(
      addData: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddItem(),
        ),
      ),
      appBarTitle: Text(
        MyTable.getStringByLocale(
            'List of items', context.read<DataCenter>().locale),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: items.isEmpty
              ? const Icon(
                  MyTable.itemIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyItemDetails(
                          index: index,
                        ),
                      ),
                    ),
                    leading: MyIcon(text: items[index].itemCode![0]),
                    title: Text(items[index].itemCode!),
                    subtitle: Text('${items[index].itemQuantity}'),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _itemQuantity = '0.0';
    String? _itemCode, _itemDescription, _itemQuality, _itemUnit, _itemCategory;
    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().insertItem(
                    MyItem.copy(
                      MyItem(
                        itemCode: _itemCode,
                        itemDescription: _itemDescription,
                        itemQuantity: double.tryParse(_itemQuantity),
                        itemUnit: _itemUnit,
                        itemCategory: _itemCategory,
                        itemQuality: _itemQuality,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLocale(
                      'Item added', context.read<DataCenter>().locale)),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ],
      showActionsButton: true,
      showFloatingButton: false,
      appBarTitle: Text(MyTable.getStringByLocale(
          'New item', context.read<DataCenter>().locale)),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _itemCode = newValue!,
                  validator: (value) {
                    bool isThere = false;
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
                      }

                      context.read<DataCenter>().itemList.forEach((item) {
                        if (item.itemCode!.toLowerCase().replaceAll(' ', '') ==
                            value.toLowerCase().replaceAll(' ', '')) {
                          isThere = true;
                        }
                      });

                      if (isThere) {
                        return MyTable.getStringByLocale('Duplicated value',
                            context.read<DataCenter>().locale);
                      }
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Code', context.read<DataCenter>().locale),
                  ),
                ),
                if (context.read<DataCenter>().addItemDescriptionField)
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemDescription = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Description', context.read<DataCenter>().locale),
                    ),
                  ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => _itemQuantity = newValue!,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
                      }

                      double? val = double.tryParse(value);
                      if (val != null) {
                        if (val < 0.0) {
                          return MyTable.getStringByLocale(
                              'Value cannot be negative',
                              context.read<DataCenter>().locale);
                        }
                      }
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Quantity', context.read<DataCenter>().locale),
                  ),
                ),
                if (context.read<DataCenter>().addItemUnitField)
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemUnit = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Unit', context.read<DataCenter>().locale),
                    ),
                  ),
                if (context.read<DataCenter>().addItemCategoryField)
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemCategory = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Category', context.read<DataCenter>().locale),
                    ),
                  ),
                if (context.read<DataCenter>().addItemQualityField)
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemQuality = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Quality', context.read<DataCenter>().locale),
                    ),
                  ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLocale('Add description field',
                      context.read<DataCenter>().locale)),
                  value: context.watch<DataCenter>().addItemDescriptionField,
                  onChanged: (bool value) => context
                      .read<DataCenter>()
                      .addItemDescriptionField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLocale(
                      'Add quality field', context.read<DataCenter>().locale)),
                  value: context.read<DataCenter>().addItemQualityField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addItemQualityField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLocale(
                      'Add unit field', context.read<DataCenter>().locale)),
                  value: context.read<DataCenter>().addItemUnitField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addItemUnitField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLocale(
                      'Add category field', context.read<DataCenter>().locale)),
                  value: context.read<DataCenter>().addItemCategoryField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addItemCategoryField = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final int index;
  const EditItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _itemQuantity = '0.0';
    String? _itemCode, _itemDescription, _itemQuality, _itemUnit, _itemCategory;
    MyItem item = context.read<DataCenter>().itemList[index];
    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().updateItem(
                    index,
                    MyItem.copy(
                      MyItem(
                        itemCode: _itemCode,
                        itemDescription: _itemDescription,
                        itemQuantity: double.tryParse(_itemQuantity),
                        itemUnit: _itemUnit,
                        itemCategory: _itemCategory,
                        itemQuality: _itemQuality,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLocale(
                      'Item edited', context.read<DataCenter>().locale)),
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ],
      showActionsButton: true,
      showFloatingButton: false,
      appBarTitle: Text(MyTable.getStringByLocale(
          'Edit item', context.read<DataCenter>().locale)),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: item.itemCode,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _itemCode = newValue!,
                  validator: (value) {
                    bool isThere = false;
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
                      }

                      List<MyItem> items = context.read<DataCenter>().itemList;
                      for (int i = 0; i < items.length; i++) {
                        if (i == index) {
                          continue;
                        }

                        if (items[i]
                                .itemCode!
                                .toLowerCase()
                                .replaceAll(' ', '') ==
                            value.toLowerCase().replaceAll(' ', '')) {
                          isThere = true;
                        }
                      }

                      if (isThere) {
                        return MyTable.getStringByLocale('Duplicated value',
                            context.read<DataCenter>().locale);
                      }
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Code', context.read<DataCenter>().locale),
                  ),
                ),
                if (context.read<DataCenter>().addItemDescriptionField)
                  TextFormField(
                    initialValue: item.itemDescription,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemDescription = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Description', context.read<DataCenter>().locale),
                    ),
                  ),
                TextFormField(
                  initialValue: '${item.itemQuantity}',
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => _itemQuantity = newValue!,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
                      }

                      double? val = double.tryParse(value);
                      if (val != null) {
                        if (val < 0.0) {
                          return MyTable.getStringByLocale(
                              'Value cannot be negative',
                              context.read<DataCenter>().locale);
                        }
                      }
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Quantity', context.read<DataCenter>().locale),
                  ),
                ),
                if (context.read<DataCenter>().addItemUnitField)
                  TextFormField(
                    initialValue: item.itemUnit,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemUnit = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Unit', context.read<DataCenter>().locale),
                    ),
                  ),
                if (context.read<DataCenter>().addItemCategoryField)
                  TextFormField(
                    initialValue: item.itemCategory,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemCategory = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Category', context.read<DataCenter>().locale),
                    ),
                  ),
                if (context.read<DataCenter>().addItemQualityField)
                  TextFormField(
                    initialValue: item.itemQuality,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemQuality = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Quality', context.read<DataCenter>().locale),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyItemDetails extends StatelessWidget {
  final int index;
  const MyItemDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Object?> item = {};

    if (index >= context.read<DataCenter>().itemList.length) {
      item = context.read<DataCenter>().itemList[index - 1].toJson();
    } else {
      item = context.read<DataCenter>().itemList[index].toJson();
    }

    String itemCode = item[MyTable.itemCodeField] as String;

    return MyScaffold(
      showActionsButton: true,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeWidget(),
            ),
          ),
          icon: const Icon(
            Icons.home,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                MyTable.getStringByLocale(
                    'Edit', context.read<DataCenter>().locale),
              ),
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditItem(
                              index: index,
                            ),
                          ),
                        ));

                return;
              },
            ),
            PopupMenuItem(
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (context) => AlertDialog(
                              title: Column(children: [
                                Text(
                                  MyTable.getStringByLocale(
                                      'Are you sure you want to delete',
                                      context.read<DataCenter>().locale),
                                ),
                                Text(
                                  itemCode,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ]),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    context.read<DataCenter>().deleteRow(
                                          MyTable.item,
                                          MyTable.itemCodeField,
                                          itemCode,
                                        );
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          )
                        });
                Navigator.pop(context);
              },
              child: Text(
                MyTable.getStringByLocale(
                    'Delete', context.read<DataCenter>().locale),
              ),
            ),
          ],
        ),
      ],
      showFloatingButton: false,
      appBarTitle: Text(
        itemCode,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Code', context.read<DataCenter>().locale)}: ${item[MyTable.itemCodeField]}',
                ),
              ),
              if ('${item[MyTable.itemDescriptionField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Description', context.read<DataCenter>().locale)}: ${item[MyTable.itemDescriptionField]}',
                  ),
                ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Quantity', context.read<DataCenter>().locale)}: ${item[MyTable.itemQuantityField]}',
                ),
              ),
              if ('${item[MyTable.itemUnitField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Unit', context.read<DataCenter>().locale)}: ${item[MyTable.itemUnitField]}',
                  ),
                ),
              if ('${item[MyTable.itemCategoryField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Category', context.read<DataCenter>().locale)}: ${item[MyTable.itemCategoryField]}',
                  ),
                ),
              if ('${item[MyTable.itemQualityField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Quality', context.read<DataCenter>().locale)}: ${item[MyTable.itemQualityField]}',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
