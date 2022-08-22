import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockmax/custom_material.dart';
import 'mytable.dart';
import 'package:provider/provider.dart';
import 'data_model.dart';

class Command extends StatelessWidget {
  const Command({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MyCommand> commands = context.watch<DataCenter>().commandList;
    return MyScaffold(
      addData: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddCommand(),
        ),
      ),
      appBarTitle: Text(
        MyTable.getStringByLocale(
            'List of commands', context.read<DataCenter>().locale),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: commands.isEmpty
              ? const Icon(
                  MyTable.commandIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: commands.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCommandDetails(
                          index: index,
                        ),
                      ),
                    ),
                    subtitle: Text(MyTable.formatDateToLocale(
                        context.read<DataCenter>().locale,
                        commands[index].commandDate!)),
                    leading: MyIcon(text: commands[index].itemCode![0]),
                    title: Text(commands[index].commandCode!),
                    trailing: Text(
                      '${commands[index].itemQuantity}',
                      //style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddCommand extends StatelessWidget {
  const AddCommand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String? _commandCode,
        _itemCode,
        _itemQuantity,
        _supplierCode = MyTable.supplierZero,
        _commandDate;
    double _finalQuantity = 0.0;

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

    List<MySupplier> supplierList = context.read<DataCenter>().supplierList;
    List<String> supplierCodeList = [];
    for (int i = 0; i < supplierList.length; i++) {
      supplierCodeList.add(supplierList[i].supplierCode!);
    }
    String _selectedValue1 =
        supplierCodeList.isNotEmpty ? supplierCodeList[0] : '';
    List<DropdownMenuItem<String>> supplierCodeDropDownMenuItem = [];

    for (int i = 0; i < supplierCodeList.length; i++) {
      supplierCodeDropDownMenuItem.add(DropdownMenuItem(
        child: Text(supplierCodeList[i]),
        value: supplierCodeList[i],
      ));
    }

    DateTime? _datetime;
    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().insertCommand(
                    MyCommand(
                      commandCode: _commandCode,
                      itemCode: _itemCode,
                      itemQuantity: double.tryParse(_itemQuantity!),
                      supplierCode: _supplierCode,
                      commandDate: _commandDate,
                    ),
                  );

              MyItem? item =
                  context.read<DataCenter>().getItemByCode(_itemCode!);
              _finalQuantity =
                  item!.itemQuantity! + (double.tryParse(_itemQuantity!)!);
              item = MyItem.copy(MyItem(
                itemCode: _itemCode,
                itemQuantity: _finalQuantity,
              ));

              context.read<DataCenter>().updateItem(item, itemCode: _itemCode!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLocale(
                      'Command added', context.read<DataCenter>().locale)),
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
          'New command', context.read<DataCenter>().locale)),
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
                    onSaved: (newValue) => _commandCode = newValue!,
                    validator: (value) {
                      bool isThere = false;
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLocale('Field is required',
                              context.read<DataCenter>().locale);
                        }

                        context
                            .read<DataCenter>()
                            .commandList
                            .forEach((command) {
                          if (command.commandCode!
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
                      });
                    },
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
                  if (context.read<DataCenter>().addCommandSupplierCodeField)
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLocale(
                            'Supplier code', context.read<DataCenter>().locale),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (newValue) => _supplierCode = newValue as String,
                      isExpanded: true,
                      items: supplierCodeDropDownMenuItem,
                      value: _selectedValue1,
                      onChanged: (selectedValue) {
                        setState(() {
                          _selectedValue1 = selectedValue as String;
                        });
                      },
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
                    onSaved: (newValue) => _commandDate =
                        DateFormat('MM/dd/yyyy').format(_datetime!),
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
                  /*TextFormField(
                    onChanged: (value) => _finalQuantity,
                    /*onSaved: (newValue) => _finalQuantity,
                    validator: (value) {
                      return null;
                    },*/
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Final quantity', context.read<DataCenter>().locale),
                    ),
                  ),*/
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(MyTable.getStringByLocale(
                        'Add supplier code field',
                        context.read<DataCenter>().locale)),
                    value:
                        context.watch<DataCenter>().addCommandSupplierCodeField,
                    onChanged: (bool value) => context
                        .read<DataCenter>()
                        .addCommandSupplierCodeField = value,
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

class MyCommandDetails extends StatelessWidget {
  final int index;
  const MyCommandDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Object?> commands = {};

    if (index >= context.read<DataCenter>().commandList.length) {
      commands = context.read<DataCenter>().commandList[index - 1].toJson();
    } else {
      commands = context.read<DataCenter>().commandList[index].toJson();
    }

    String commandCode = commands[MyTable.commandCodeField] as String;
    return MyScaffold(
        showActionsButton: true,
        showFloatingButton: false,
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
              /*PopupMenuItem(
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
                              builder: (context) => EditCommand(
                                index: index,
                              ),
                            ),
                          ));

                  return;
                },
              ),*/
              PopupMenuItem(
                onTap: () {
                  Future.delayed(
                      const Duration(seconds: 0),
                      () => {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (context) => AlertDialog(
                                title: Column(children: [
                                  Text(
                                    MyTable.getStringByLocale(
                                        'Are you sure you want to delete',
                                        context.read<DataCenter>().locale),
                                  ),
                                  Text(
                                    commandCode,
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
                                            MyTable.command,
                                            MyTable.commandCodeField,
                                            commandCode,
                                          );
                                      String itemCode =
                                          commands[MyTable.itemCodeField]
                                              as String;
                                      MyItem? item = context
                                          .read<DataCenter>()
                                          .getItemByCode(itemCode);

                                      item = MyItem.copy(MyItem(
                                        itemCode: itemCode,
                                        itemQuantity: item!.itemQuantity! -
                                            (commands[MyTable
                                                .itemQuantityField]! as double),
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
                  MyTable.getStringByLocale(
                      'Delete', context.read<DataCenter>().locale),
                ),
              ),
            ],
          ),
        ],
        appBarTitle: Text(commandCode),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Code', context.read<DataCenter>().locale)}: ${commands[MyTable.commandCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Item code', context.read<DataCenter>().locale)}: ${commands[MyTable.itemCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Quantity', context.read<DataCenter>().locale)}: ${commands[MyTable.itemQuantityField]}',
                ),
              ),
              if ('${commands[MyTable.supplierCodeField]}'.isNotEmpty &&
                  commands[MyTable.supplierCodeField] as String !=
                      MyTable.supplierZero)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Supplier code', context.read<DataCenter>().locale)}: ${commands[MyTable.supplierCodeField]}',
                  ),
                ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Date', context.read<DataCenter>().locale)}: ${MyTable.formatDateToLocale(context.read<DataCenter>().locale, commands[MyTable.commandDateField] as String)}',
                ),
              ),
            ]),
          ),
        ));
  }
}
