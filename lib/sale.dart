import 'package:flutter/material.dart';
import 'data_model.dart';
import 'package:provider/provider.dart';
import 'custom_material.dart';
import 'package:intl/intl.dart';
import 'mytable.dart';

class Sale extends StatelessWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MySale> items = context.watch<DataCenter>().saleList;
    return MyScaffold(
      addData: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSale(),
          ),
        );
      },
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'List of sales', context.read<DataCenter>().languageCode)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: items.isEmpty
              ? const Icon(
                  MyTable.saleIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MySaleDetails(
                          index: index,
                        ),
                      ),
                    ),
                    leading: MyIcon(
                      text: items[index].saleCode![0],
                    ),
                    title: Text(items[index].saleCode!),
                    subtitle: Text('${items[index].itemCode}'),
                    trailing: Text('${items[index].itemQuantity}'),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddSale extends StatelessWidget {
  const AddSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _saleCode,
        _itemCode,
        _customerCode = MyTable.customerZero,
        _saleDate;
    String _itemQuantity = '0.0';
    String _saleCost = '0.0';
    List<MyItem> itemList = context.read<DataCenter>().itemList;
    List<String> itemCodeList = [];
    for (int i = 0; i < itemList.length; i++) {
      itemCodeList.add(itemList[i].itemCode!);
    }
    String _selectedValue = itemCodeList.isNotEmpty ? itemCodeList[0] : '';
    List<DropdownMenuItem<String>> itemCodeDropDownMenuItem = [];

    for (int i = 0; i < itemCodeList.length; i++) {
      itemCodeDropDownMenuItem.add(DropdownMenuItem(
        child: Text(itemCodeList[i]),
        value: itemCodeList[i],
      ));
    }

    double _quantityInStock =
        itemList.isNotEmpty ? itemList[0].itemQuantity! : 0.0;

    List<MyCustomer> customerList = context.read<DataCenter>().customerList;
    List<String> customerCodeList = [];
    for (int i = 0; i < customerList.length; i++) {
      customerCodeList.add(customerList[i].customerCode!);
    }
    String _selectedValue1 =
        customerCodeList.isNotEmpty ? customerCodeList[0] : '';
    List<DropdownMenuItem<String>> customerCodeDropDownMenuItem = [];
    for (int i = 0; i < customerCodeList.length; i++) {
      customerCodeDropDownMenuItem.add(DropdownMenuItem(
        child: Text(customerCodeList[i]),
        value: customerCodeList[i],
      ));
    }

    DateTime? _datetime;
    bool _value = false;

    return MyScaffold(
      actions: [
        /*StatefulBuilder(
          builder: (context, setState) {
            return IconButton(
              onPressed: () {
                _formKey.currentState!.save();
                List<MyItemPriceAtDate> pricesHistory = [];
                context.read<DataCenter>().itemPriceAtDateList.forEach((price) {
                  if (price.itemCode == _selectedValue) {
                    pricesHistory.add(price);
                  }
                });

                double _lastPrice = 0.0;
                DateTime _lastDate = DateTime(1800);
                for (MyItemPriceAtDate price in pricesHistory) {
                  if (_lastDate.isBefore(DateTime.parse(price.atDate!))) {
                    _lastDate = DateTime.parse(price.atDate!);
                    _lastPrice = price.itemPrice!;
                  }
                }

                setState(
                  () {
                    _saleCost = (double.tryParse(_itemQuantity)! * _lastPrice)
                        .toString();
                  },
                );
              },
              icon: const Icon(
                Icons.attach_money,
              ),
            );
          },
        ),*/
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().insertSale(
                    MySale.copy(
                      MySale(
                        saleCode: _saleCode,
                        itemCode: _itemCode,
                        customerCode: _customerCode,
                        itemQuantity: double.tryParse(_itemQuantity),
                        saleCost: double.tryParse(_saleCost),
                        saleDate: _saleDate,
                      ),
                    ),
                  );

              MyItem? item =
                  context.read<DataCenter>().getItemByCode(_itemCode!);
              item = MyItem.copy(MyItem(
                itemCode: _itemCode,
                itemQuantity:
                    item!.itemQuantity! - (double.tryParse(_itemQuantity)!),
                itemDescription: item.itemDescription,
                itemCategory: item.itemCategory,
                itemQuality: item.itemQuality,
                itemUnit: item.itemUnit,
              ));

              context.read<DataCenter>().updateItem(item, itemCode: _itemCode!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Sale added', context.read<DataCenter>().languageCode)),
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
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'New sale', context.read<DataCenter>().languageCode)),
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
                    onSaved: (newValue) => _saleCode = newValue,
                    validator: (value) {
                      bool isThere = false;
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }

                        context.read<DataCenter>().saleList.forEach((item) {
                          if (item.saleCode!
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
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Item code', context.read<DataCenter>().languageCode),
                    ),
                    validator: (value) {
                      return null;
                    },
                    onSaved: (newValue) => _itemCode = newValue as String,
                    isExpanded: true,
                    items: itemCodeDropDownMenuItem,
                    value: _selectedValue,
                    onChanged: (selectedValue) {
                      setState(() {
                        _selectedValue = selectedValue as String;
                        for (MyItem element in itemList) {
                          if (element.itemCode == _selectedValue) {
                            _quantityInStock = element.itemQuantity!;
                            break;
                          }
                        }
                      });
                    },
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

                        double? quantity = double.tryParse(value);
                        if (quantity! > _quantityInStock) {
                          return MyTable.getStringByLanguageCode(
                              'Insufficient stock',
                              context.read<DataCenter>().languageCode);
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
                    //initialValue: _saleCost,
                    controller: TextEditingController(text: _saleCost),
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => _saleCost = newValue!,
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
                      labelText: MyTable.getStringByLanguageCode('Total cost',
                          context.read<DataCenter>().languageCode),
                      suffixIcon: IconButton(
                        onPressed: () {
                          List<MyItemPriceAtDate> pricesHistory = [];
                          context
                              .read<DataCenter>()
                              .itemPriceAtDateList
                              .forEach((price) {
                            if (price.itemCode == _selectedValue) {
                              pricesHistory.add(price);
                            }
                          });

                          double _lastPrice = 0.0;
                          DateTime _lastDate = DateTime(1800);
                          for (MyItemPriceAtDate price in pricesHistory) {
                            if (_lastDate
                                .isBefore(DateTime.parse(price.atDate!))) {
                              _lastDate = DateTime.parse(price.atDate!);
                              _lastPrice = price.itemPrice!;
                            }
                          }

                          setState(
                            () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _saleCost = (double.tryParse(_itemQuantity)! *
                                        _lastPrice)
                                    .toString();
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.attach_money),
                      ),
                    ),
                  ),
                  /*StatefulBuilder(builder: (context, setState) {
                    return TextFormField(
                      //initialValue: _saleCost,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => _saleCost = newValue!,
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
                        labelText: MyTable.getStringByLanguageCode(
                            'Total cost', context.read<DataCenter>().languageCode),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _saleCost = '1200';
                              },
                            );
                          },
                          icon: const Icon(Icons.attach_money),
                        ),
                      ),
                    );
                  }),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => _saleCost = newValue!,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode('Field is required',
                              context.read<DataCenter>().languageCode);
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Total cost', context.read<DataCenter>().languageCode),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_money),
                      ),
                    ),
                  ),*/
                  TextFormField(
                    controller: TextEditingController(
                        text: _datetime == null
                            ? ''
                            : DateFormat(
                                    context.read<DataCenter>().languageCode ==
                                            'en'
                                        ? MyTable.enDateFormat
                                        : MyTable.frDateFormat)
                                .format(_datetime!)),
                    readOnly: true,
                    onSaved: (newValue) => _saleDate =
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
                  if (_value) //if (context.read<DataCenter>().addSaleCustomerCodeField)
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Customer code',
                            context.read<DataCenter>().languageCode),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (newValue) => _customerCode = newValue as String,
                      isExpanded: true,
                      items: customerCodeDropDownMenuItem,
                      value: _selectedValue1,
                      onChanged: (selectedValue) {
                        setState(() {
                          _selectedValue1 = selectedValue as String;
                        });
                      },
                    ),
                  SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        MyTable.getStringByLanguageCode('Add customer field',
                            context.read<DataCenter>().languageCode),
                      ),
                      value: _value,
                      onChanged: (bool value) {
                        setState(() {
                          _value = value;
                        });
                      } /*=> context
                          .read<DataCenter>()
                          .addSaleCustomerCodeField = value,*/
                      ),
                  /*StatefulBuilder(builder: (context, setState) {
                    return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          MyTable.getStringByLanguageCode('Add customer field',
                              context.read<DataCenter>().languageCode),
                        ),
                        value: _value,
                        onChanged: (bool value) {
                          setState(() {
                            _value = value;
                          });
                        } /*=> context
                          .read<DataCenter>()
                          .addSaleCustomerCodeField = value,*/
                        );
                  }),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      MyTable.getStringByLanguageCode('Add customer field',
                          context.read<DataCenter>().languageCode),
                    ),
                    value: context.watch<DataCenter>().addSaleCustomerCodeField,
                    onChanged: (bool value) => context
                        .read<DataCenter>()
                        .addSaleCustomerCodeField = value,
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

class MySaleDetails extends StatelessWidget {
  final int index;
  const MySaleDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Object?> sales = {};
    if (index >= context.read<DataCenter>().saleList.length) {
      sales = context.read<DataCenter>().saleList[index - 1].toJson();
    } else {
      sales = context.read<DataCenter>().saleList[index].toJson();
    }

    String saleCode = '${sales[MyTable.saleCodeField]}';

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
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (context) => AlertDialog(
                              title: Text(
                                '${MyTable.getStringByLanguageCode('Are you sure you want to delete', context.read<DataCenter>().languageCode)} $saleCode',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    context.read<DataCenter>().deleteRow(
                                          MyTable.sale,
                                          MyTable.saleCodeField,
                                          saleCode,
                                        );

                                    String itemCode =
                                        sales[MyTable.itemCodeField] as String;
                                    MyItem? item = context
                                        .read<DataCenter>()
                                        .getItemByCode(itemCode);

                                    item = MyItem.copy(MyItem(
                                      itemCode: itemCode,
                                      itemQuantity: item!.itemQuantity! +
                                          (sales[MyTable.itemQuantityField]!
                                              as double),
                                    ));

                                    context
                                        .read<DataCenter>()
                                        .updateItem(item, itemCode: itemCode);
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
        saleCode,
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
                  '${MyTable.getStringByLanguageCode('Code', context.read<DataCenter>().languageCode)}: ${sales[MyTable.saleCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Item code', context.read<DataCenter>().languageCode)}: ${sales[MyTable.itemCodeField]}',
                ),
              ),
              if ({sales[MyTable.customerCodeField]}.isNotEmpty &&
                  sales[MyTable.customerCodeField] as String !=
                      MyTable.customerZero)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLanguageCode('Customer code', context.read<DataCenter>().languageCode)}: ${sales[MyTable.customerCodeField]}',
                  ),
                ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Quantity', context.read<DataCenter>().languageCode)}: ${sales[MyTable.itemQuantityField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Total cost', context.read<DataCenter>().languageCode)}: ${sales[MyTable.saleCostField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Date', context.read<DataCenter>().languageCode)}: ${MyTable.formatDateToLanguageCode(context.read<DataCenter>().languageCode, sales[MyTable.saleDateField] as String)}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
