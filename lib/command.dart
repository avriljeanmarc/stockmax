import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockmax/materials.dart';
import 'mytable.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'more.dart';

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
        MyTable.getStringByLanguageCode(
            'List of commands', context.read<DataCenter>().languageCode),
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
                    subtitle: Text(MyTable.formatDateToLanguageCode(
                        context.read<DataCenter>().languageCode,
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
    bool _value = false;
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
                itemDescription: item.itemDescription,
                itemCategory: item.itemCategory,
                itemQuality: item.itemQuality,
                itemUnit: item.itemUnit,
              ));

              context.read<DataCenter>().updateItem(item, itemCode: _itemCode!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode('Command added',
                      context.read<DataCenter>().languageCode)),
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
          'New command', context.read<DataCenter>().languageCode)),
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
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
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
                    onSaved: (newValue) => _commandDate =
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
                  if (_value) //if (context.read<DataCenter>().addCommandSupplierCodeField)
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier code',
                            context.read<DataCenter>().languageCode),
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
                  /*TextFormField(
                    onChanged: (value) => _finalQuantity,
                    /*onSaved: (newValue) => _finalQuantity,
                    validator: (value) {
                      return null;
                    },*/
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Final quantity', context.read<DataCenter>().languageCode),
                    ),
                  ),*/
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(MyTable.getStringByLanguageCode(
                        'Add supplier code field',
                        context.read<DataCenter>().languageCode)),
                    value: _value,
                    onChanged: (bool value) {
                      setState(() {
                        _value = value;
                      });
                    },
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
                  MyTable.getStringByLanguageCode(
                      'Edit', context.read<DataCenter>().languageCode),
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
                                    MyTable.getStringByLanguageCode(
                                        'Are you sure you want to delete',
                                        context
                                            .read<DataCenter>()
                                            .languageCode),
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
                  MyTable.getStringByLanguageCode(
                      'Delete', context.read<DataCenter>().languageCode),
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
                  '${MyTable.getStringByLanguageCode('Code', context.read<DataCenter>().languageCode)}: ${commands[MyTable.commandCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Item code', context.read<DataCenter>().languageCode)}: ${commands[MyTable.itemCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Quantity', context.read<DataCenter>().languageCode)}: ${commands[MyTable.itemQuantityField]}',
                ),
              ),
              if ('${commands[MyTable.supplierCodeField]}'.isNotEmpty &&
                  commands[MyTable.supplierCodeField] as String !=
                      MyTable.supplierZero)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLanguageCode('Supplier code', context.read<DataCenter>().languageCode)}: ${commands[MyTable.supplierCodeField]}',
                  ),
                ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLanguageCode('Date', context.read<DataCenter>().languageCode)}: ${MyTable.formatDateToLanguageCode(context.read<DataCenter>().languageCode, commands[MyTable.commandDateField] as String)}',
                ),
              ),
            ]),
          ),
        ));
  }
}
