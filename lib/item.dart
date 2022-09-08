import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data_model.dart';
import 'package:provider/provider.dart';
import 'custom_material.dart';
import 'mytable.dart';

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
        MyTable.getStringByLanguageCode(
            'List of items', context.read<DataCenter>().languageCode),
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
                    subtitle: Text(items[index].itemDescription!),
                    leading: MyIcon(text: items[index].itemCode![0]),
                    title: Text(items[index].itemCode!),
                    trailing: items[index].itemQuantity! <= 100
                        ? Text(
                            '${items[index].itemQuantity}',
                            style: const TextStyle(color: Colors.red),
                          )
                        : Text(
                            '${items[index].itemQuantity}',
                            style: const TextStyle(color: Colors.green),
                          ),
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
    String? _itemQuantity,
        _itemCode,
        _itemDescription,
        _itemQuality,
        _itemUnit,
        _itemCategory;

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().insertItem(
                    MyItem.copy(MyItem(
                      itemCode: _itemCode,
                      itemDescription: _itemDescription,
                      itemQuantity: double.tryParse(_itemQuantity!),
                      itemUnit: _itemUnit,
                      itemCategory: _itemCategory,
                      itemQuality: _itemQuality,
                    )),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Item added', context.read<DataCenter>().languageCode)),
                ),
              );
              Navigator.pop(context);
              //Navigator.pop(context);
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
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'New item', context.read<DataCenter>().languageCode)),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Form(
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
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }

                        context.read<DataCenter>().itemList.forEach((item) {
                          if (item.itemCode!
                                  .toLowerCase()
                                  .replaceAll(' ', '') ==
                              value.toLowerCase().replaceAll(' ', '')) {
                            isThere = true;
                          }
                        });

                        if (isThere) {
                          return MyTable.getStringByLanguageCode(
                              'Duplicated value',
                              context.read<DataCenter>().languageCode);
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Code', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => _itemQuantity = newValue!,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }

                        double? val = double.tryParse(value);
                        if (val != null) {
                          if (val < 0.0) {
                            return MyTable.getStringByLanguageCode(
                                'Value cannot be negative',
                                context.read<DataCenter>().languageCode);
                          }
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Quantity', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemDescription = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode('Description',
                          context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemUnit = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Unit', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemCategory = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Category', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemQuality = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Quality', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  /*SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(MyTable.getStringByLanguageCode(
                        'Add description field',
                        context.read<DataCenter>().languageCode)),
                    value: _value,
                    onChanged: (bool value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(MyTable.getStringByLanguageCode(
                        'Add unit field', context.read<DataCenter>().languageCode)),
                    value: _value1,
                    onChanged: (bool value) {
                      setState(() {
                        _value1 = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(MyTable.getStringByLanguageCode('Add category field',
                        context.read<DataCenter>().languageCode)),
                    value: _value2,
                    onChanged: (bool value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(MyTable.getStringByLanguageCode('Add quality field',
                        context.read<DataCenter>().languageCode)),
                    value: _value3,
                    onChanged: (bool value) {
                      setState(() {
                        _value3 = value;
                      });
                    },
                  ),*/
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class EditItemPrice extends StatelessWidget {
  final String itemCode;
  const EditItemPrice({Key? key, required this.itemCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String? _itemPrice, _atDate;
    DateTime? _datetime;
    bool isThere = false;

    return MyScaffold(
      showActionsButton: true,
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().itemPriceAtDateList.forEach((price) {
                if (price.itemCode == itemCode && price.atDate == _atDate) {
                  isThere = true;
                }
              });
              if (!isThere) {
                context.read<DataCenter>().insertItemPriceAtDate(
                      MyItemPriceAtDate.copy(MyItemPriceAtDate(
                        itemCode: itemCode,
                        atDate: _atDate,
                        itemPrice: double.tryParse(_itemPrice!),
                      )),
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(MyTable.getStringByLanguageCode(
                        'Price edited',
                        context.read<DataCenter>().languageCode)),
                  ),
                );
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (context) => AlertDialog(
                              title: Column(children: [
                                Text(
                                  MyTable.getStringByLanguageCode(
                                      'Duplicated value',
                                      context.read<DataCenter>().languageCode),
                                ),
                                Text(
                                  '$itemCode - ${MyTable.formatDateToLanguageCode(context.read<DataCenter>().languageCode, _atDate!)}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ]),
                              actions: [
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
              }
            }
          },
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ],
      showFloatingButton: false,
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'Edit price', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => _itemPrice = newValue!,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          double? val = double.tryParse(value);
                          if (val != null) {
                            if (val < 0.0) {
                              return MyTable.getStringByLanguageCode(
                                  'Value cannot be negative',
                                  context.read<DataCenter>().languageCode);
                            }
                          }
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Price', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: _datetime == null
                              ? ''
                              : DateFormat(
                                      context.read<DataCenter>().languageCode ==
                                              'US'
                                          ? MyTable.enDateFormat
                                          : MyTable.frDateFormat)
                                  .format(_datetime!)),
                      readOnly: true,
                      onSaved: (newValue) => _atDate =
                          DateFormat(MyTable.saveDateFormat).format(_datetime!),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => showDatePicker(
                                  locale: Locale(
                                      context.read<DataCenter>().languageCode),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(5000))
                              .then((value) => setState(() {
                                    _datetime = value;
                                  })),
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                        labelText: MyTable.getStringByLanguageCode(
                            'Date', context.read<DataCenter>().languageCode),
                      ),
                    ),
                  ],
                ),
              );
            },
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

    String? _itemCode,
        _itemDescription,
        _itemQuality,
        _itemUnit,
        _itemQuantity,
        _itemCategory;
    MyItem item = context.read<DataCenter>().itemList[index];

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().updateItem(
                    MyItem.copy(MyItem(
                      itemCode: _itemCode,
                      itemDescription: _itemDescription,
                      itemQuantity: double.tryParse(_itemQuantity!),
                      itemUnit: _itemUnit,
                      itemCategory: _itemCategory,
                      itemQuality: _itemQuality,
                    )),
                    index: index,
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Item edited', context.read<DataCenter>().languageCode)),
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
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'Edit item', context.read<DataCenter>().languageCode)),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
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
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          List<MyItem> items =
                              context.read<DataCenter>().itemList;
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
                            return MyTable.getStringByLanguageCode(
                                'Duplicated value',
                                context.read<DataCenter>().languageCode);
                          }
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Code', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: item.itemQuantity.toString(),
                      enabled: false,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => _itemQuantity = newValue!,
                      /*validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          double? val = double.tryParse(value);
                          if (val != null) {
                            if (val < 0.0) {
                              return MyTable.getStringByLanguageCode(
                                  'Value cannot be negative',
                                  context.read<DataCenter>().languageCode);
                            }
                          }
                        }

                        return null;
                      },*/
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('Quantity',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      //initialValue: item.itemDescription,
                      controller: TextEditingController(
                        text: item.itemDescription,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _itemDescription = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Description',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      //initialValue: item.itemUnit,
                      controller: TextEditingController(
                        text: item.itemUnit,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _itemUnit = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Unit', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      //initialValue: item.itemCategory,
                      controller: TextEditingController(
                        text: item.itemCategory,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _itemCategory = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('Category',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      //initialValue: item.itemQuality,
                      controller: TextEditingController(
                        text: item.itemQuality,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _itemQuality = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Quality', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    /* SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(MyTable.getStringByLanguageCode(
                          'Add description field',
                          context.read<DataCenter>().languageCode)),
                      value: _value,
                      onChanged: (bool value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(MyTable.getStringByLanguageCode(
                          'Add unit field', context.read<DataCenter>().languageCode)),
                      value: _value1,
                      onChanged: (bool value) {
                        setState(() {
                          _value1 = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(MyTable.getStringByLanguageCode(
                          'Add category field',
                          context.read<DataCenter>().languageCode)),
                      value: _value2,
                      onChanged: (bool value) {
                        setState(() {
                          _value2 = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(MyTable.getStringByLanguageCode('Add quality field',
                          context.read<DataCenter>().languageCode)),
                      value: _value3,
                      onChanged: (bool value) {
                        setState(() {
                          _value3 = value;
                        });
                      },
                    ),

                    if (context.read<DataCenter>().addItemDescriptionField)
                  //if ('${item.itemDescription}'.isNotEmpty)
                  TextFormField(
                    initialValue: item.itemDescription,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemDescription = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Description', context.read<DataCenter>().languageCode),
                    ),
                  ),
                TextFormField(
                  initialValue: '${item.itemQuantity}',
                  readOnly: true,
                  onSaved: (newValue) => _itemQuantity = newValue,
                  /*validator: (value) {
                    return null;
                  },*/
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLanguageCode(
                        'Quantity', context.read<DataCenter>().languageCode),
                  ),
                ),
                if (context.read<DataCenter>().addItemUnitField)
                  //if ('${item.itemUnit}'.isNotEmpty)
                  TextFormField(
                    initialValue: item.itemUnit,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemUnit = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Unit', context.read<DataCenter>().languageCode),
                    ),
                  ),
                if (context.read<DataCenter>().addItemCategoryField)
                  //if ('${item.itemCategory}'.isNotEmpty)
                  TextFormField(
                    initialValue: item.itemCategory,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemCategory = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Category', context.read<DataCenter>().languageCode),
                    ),
                  ),
                if (context.read<DataCenter>().addItemQualityField)
                  //if ('${item.itemQuality}'.isNotEmpty)
                  TextFormField(
                    initialValue: item.itemQuality,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _itemQuality = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Quality', context.read<DataCenter>().languageCode),
                    ),
                  ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLanguageCode('Add description field',
                      context.read<DataCenter>().languageCode)),
                  value: context.watch<DataCenter>().addItemDescriptionField,
                  onChanged: (bool value) => context
                      .read<DataCenter>()
                      .addItemDescriptionField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLanguageCode(
                      'Add quality field', context.read<DataCenter>().languageCode)),
                  value: context.read<DataCenter>().addItemQualityField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addItemQualityField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLanguageCode(
                      'Add unit field', context.read<DataCenter>().languageCode)),
                  value: context.read<DataCenter>().addItemUnitField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addItemUnitField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLanguageCode(
                      'Add category field', context.read<DataCenter>().languageCode)),
                  value: context.read<DataCenter>().addItemCategoryField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addItemCategoryField = value,
                ),*/
                  ],
                ),
              );
            },
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
                MyTable.getStringByLanguageCode(
                    'Edit price', context.read<DataCenter>().languageCode),
              ),
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditItemPrice(
                              itemCode: itemCode,
                            ),
                          ),
                        ));

                return;
              },
            ),
            PopupMenuItem(
              child: Text(
                MyTable.getStringByLanguageCode(
                    'Edit', context.read<DataCenter>().languageCode),
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
                                  MyTable.getStringByLanguageCode(
                                      'Are you sure you want to delete',
                                      context.read<DataCenter>().languageCode),
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
                MyTable.getStringByLanguageCode(
                    'Delete', context.read<DataCenter>().languageCode),
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
                  '${MyTable.getStringByLanguageCode('Code', context.read<DataCenter>().languageCode)}: ${item[MyTable.itemCodeField]}',
                ),
              ),
              if ('${item[MyTable.itemDescriptionField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLanguageCode('Description', context.read<DataCenter>().languageCode)}: ${item[MyTable.itemDescriptionField]}',
                  ),
                ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Quantity', context.read<DataCenter>().languageCode)}: ${item[MyTable.itemQuantityField]}',
                ),
              ),
              if ('${item[MyTable.itemUnitField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLanguageCode('Unit', context.read<DataCenter>().languageCode)}: ${item[MyTable.itemUnitField]}',
                  ),
                ),
              if ('${item[MyTable.itemCategoryField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLanguageCode('Category', context.read<DataCenter>().languageCode)}: ${item[MyTable.itemCategoryField]}',
                  ),
                ),
              if ('${item[MyTable.itemQualityField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLanguageCode('Quality', context.read<DataCenter>().languageCode)}: ${item[MyTable.itemQualityField]}',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
