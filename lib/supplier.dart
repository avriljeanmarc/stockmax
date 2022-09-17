import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';
import 'materials.dart';
import 'mytable.dart';
import 'more.dart';

class Supplier extends StatelessWidget {
  const Supplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MySupplier> suppliers = context.watch<DataCenter>().supplierList;
    return MyScaffold(
      addData: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddSupplier(),
        ),
      ),
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'List of suppliers', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: suppliers.isEmpty
              ? const Icon(
                  MyTable.supplierIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MySupplierDetails(
                          index: index,
                        ),
                      ),
                    ),
                    leading: MyIcon(
                      text: suppliers[index].supplierCode![0],
                    ),
                    title: Text(suppliers[index].supplierCode!),
                    subtitle: Text('${suppliers[index].supplierAddress}'),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddSupplier extends StatelessWidget {
  const AddSupplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _supplierCode, _supplierName, _supplierAddress, _supplierEmail;
    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().insertSupplier(
                    MySupplier.copy(
                      MySupplier(
                        supplierCode: _supplierCode,
                        supplierName: _supplierName,
                        supplierAddress: _supplierAddress,
                        supplierEmail: _supplierEmail,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Supplier added',
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
          'New supplier', context.read<DataCenter>().languageCode)),
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
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _supplierCode = newValue!,
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
                              .supplierList
                              .forEach((item) {
                            if (item.supplierCode!
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
                    //if (context.read<DataCenter>().addItemDescriptionField)
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _supplierName = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier name',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _supplierAddress = newValue!,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier address',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    //if (context.read<DataCenter>().addItemUnitField)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => _supplierEmail = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier e-mail',
                            context.read<DataCenter>().languageCode),
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

class MySupplierDetails extends StatelessWidget {
  final int index;
  const MySupplierDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySupplier supplier = context.read<DataCenter>().supplierList[index];

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
                    'Edit', context.read<DataCenter>().languageCode),
              ),
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSupplier(
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
                                  supplier.supplierCode!,
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
                                          MyTable.supplier,
                                          MyTable.supplierCodeField,
                                          supplier.supplierCode!,
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
        supplier.supplierCode!,
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
                subtitle: Text(supplier.supplierCode!),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Code', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (supplier.supplierName!.isNotEmpty)
                ListTile(
                  subtitle: Text(supplier.supplierName!),
                  title: Text(
                    MyTable.getStringByLanguageCode('Supplier name',
                        context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (supplier.supplierAddress!.isNotEmpty)
                ListTile(
                  subtitle: Text(supplier.supplierAddress!),
                  title: Text(
                    MyTable.getStringByLanguageCode('Supplier address',
                        context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (supplier.supplierEmail!.isNotEmpty)
                ListTile(
                  subtitle: Text(supplier.supplierEmail!),
                  title: Text(
                    MyTable.getStringByLanguageCode('Supplier e-mail',
                        context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditSupplier extends StatelessWidget {
  final int index;
  const EditSupplier({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _supplierCode, _supplierName, _supplierAddress, _supplierEmail;

    MySupplier supplier = context.read<DataCenter>().supplierList[index];

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().updateSupplier(
                    index,
                    MySupplier.copy(
                      MySupplier(
                        supplierCode: _supplierCode,
                        supplierName: _supplierName,
                        supplierAddress: _supplierAddress,
                        supplierEmail: _supplierEmail,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Supplier edited',
                      context.read<DataCenter>().languageCode)),
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
      appBarTitle: Text(supplier.supplierCode!),
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
                      initialValue: supplier.supplierCode,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _supplierCode = newValue!,
                      validator: (value) {
                        bool isThere = false;
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          List<MySupplier> suppliers =
                              context.read<DataCenter>().supplierList;
                          for (int i = 0; i < suppliers.length; i++) {
                            if (i == index) {
                              continue;
                            }

                            if (suppliers[i]
                                    .supplierCode!
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
                    //if (context.read<DataCenter>().addItemDescriptionField)
                    TextFormField(
                      initialValue: supplier.supplierName,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _supplierName = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier name',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: supplier.supplierAddress,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _supplierAddress = newValue!,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier address',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    //if (context.read<DataCenter>().addItemUnitField)
                    TextFormField(
                      initialValue: supplier.supplierEmail,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => _supplierEmail = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Supplier e-mail',
                            context.read<DataCenter>().languageCode),
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
