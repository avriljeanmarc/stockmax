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
      appBarTitle: Text(MyTable.getStringByLocale(
          'List of sales', context.read<DataCenter>().locale)),
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
                    subtitle: Text(
                        '${items[index].itemCode} ${items[index].itemQuantity}'),
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
        _itemQuantity,
        _saleDate;
    List<String> itemCodeList = context.read<DataCenter>().getItemCodeList();
    String _selectedValue = itemCodeList.isNotEmpty ? itemCodeList[0] : '';
    List<DropdownMenuItem<String>> itemCodeDropDownMenuItem = [];

    for (int i = 0; i < itemCodeList.length; i++) {
      itemCodeDropDownMenuItem.add(DropdownMenuItem(
        child: Text(itemCodeList[i]),
        value: itemCodeList[i],
      ));
    }

    double _quantityInStock =
        context.read<DataCenter>().getItemQuantityInStock(_selectedValue);

    List<String> customerCodeList =
        context.read<DataCenter>().getCustomerCodeList();
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

    return MyScaffold(
      actions: [
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
                        itemQuantity: double.tryParse(_itemQuantity!),
                        saleDate: _saleDate,
                      ),
                    ),
                  );

              MyItem? item =
                  context.read<DataCenter>().getItemByCode(_itemCode!);
              item = MyItem.copy(MyItem(
                itemCode: _itemCode,
                itemQuantity:
                    item!.itemQuantity! - (double.tryParse(_itemQuantity!)!),
              ));

              context.read<DataCenter>().updateItem(item, itemCode: _itemCode!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLocale(
                      'Sale added', context.read<DataCenter>().locale)),
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
          'New sale', context.read<DataCenter>().locale)),
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
                          return MyTable.getStringByLocale('Field is required',
                              context.read<DataCenter>().locale);
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
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Item code', context.read<DataCenter>().locale),
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
                        _quantityInStock = context
                            .read<DataCenter>()
                            .getItemQuantityInStock(_selectedValue);
                      });
                    },
                  ),
                  if (context.read<DataCenter>().addSaleCustomerCodeField)
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLocale(
                            'Customer code', context.read<DataCenter>().locale),
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => _itemQuantity = newValue,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLocale('Field is required',
                              context.read<DataCenter>().locale);
                        }

                        double? quantity = double.tryParse(value);
                        if (quantity! > _quantityInStock) {
                          return MyTable.getStringByLocale('Insufficient stock',
                              context.read<DataCenter>().locale);
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Quantity', context.read<DataCenter>().locale),
                    ),
                  ),
                  TextFormField(
                    controller: TextEditingController(
                        text: _datetime == null
                            ? ''
                            : DateFormat(
                                    context.read<DataCenter>().locale == 'US'
                                        ? 'MM/dd/yyyy'
                                        : 'dd/MM/yyyy')
                                .format(_datetime!)),
                    readOnly: true,
                    onSaved: (newValue) =>
                        _saleDate = DateFormat('MM/dd/yyyy').format(_datetime!),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLocale('Field is required',
                              context.read<DataCenter>().locale);
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => showDatePicker(
                                locale:
                                    context.read<DataCenter>().locale == 'US'
                                        ? const Locale('en', 'US')
                                        : const Locale('fr', 'FR'),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(5000))
                            .then((value) => setState(() {
                                  _datetime = value;
                                })),
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                      labelText: MyTable.getStringByLocale(
                          'Date', context.read<DataCenter>().locale),
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      MyTable.getStringByLocale('Add customer field',
                          context.read<DataCenter>().locale),
                    ),
                    value: context.watch<DataCenter>().addSaleCustomerCodeField,
                    onChanged: (bool value) => context
                        .read<DataCenter>()
                        .addSaleCustomerCodeField = value,
                  ),
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
    Map<String, Object?> item = {};
    if (index >= context.read<DataCenter>().saleList.length) {
      item = context.read<DataCenter>().saleList[index - 1].toJson();
    } else {
      item = context.read<DataCenter>().saleList[index].toJson();
    }

    String saleCode = '${item[MyTable.saleCodeField]}';

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
                /*  Future.delayed(
                      const Duration(seconds: 0),
                      () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditItem(
                                index: index,
                              ),
                            ),
                          ));*/
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
                              title: Text(
                                '${MyTable.getStringByLocale('Are you sure you want to delete', context.read<DataCenter>().locale)} $saleCode',
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
                  '${MyTable.getStringByLocale('Code', context.read<DataCenter>().locale)}: ${item[MyTable.saleCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Item code', context.read<DataCenter>().locale)}: ${item[MyTable.itemCodeField]}',
                ),
              ),
              if ({item[MyTable.customerCodeField]}.isNotEmpty &&
                  item[MyTable.customerCodeField] as String !=
                      MyTable.customerZero)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Customer code', context.read<DataCenter>().locale)}: ${item[MyTable.customerCodeField]}',
                  ),
                ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Quantity', context.read<DataCenter>().locale)}: ${item[MyTable.itemQuantityField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Date', context.read<DataCenter>().locale)}: ${context.read<DataCenter>().locale == 'US' ? item[MyTable.saleDateField] : MyTable.formatDateToLocale('FR', item[MyTable.saleDateField] as String)}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaleSettings extends StatelessWidget {
  const SaleSettings({Key? key}) : super(key: key);

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
          'Sales data', context.read<DataCenter>().locale)),
      child: Column(
        children: const [
          /*SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add customer field', context.read<DataCenter>().locale)),
            value: context.watch<DataCenter>().addSaleCustomerCodeField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addSaleCustomerCodeField = value,
          ),*/
        ],
      ),
    );
  }
}
