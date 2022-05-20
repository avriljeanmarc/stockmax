import 'package:flutter/material.dart';
import 'data_model.dart';
import 'package:provider/provider.dart';
import 'custom_material.dart';
import 'mytable.dart';

class Supplier extends StatelessWidget {
  const Supplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MySupplier> items = context.watch<DataCenter>().supplierList;
    return MyScaffold(
      addData: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddSupplier(),
        ),
      ),
      appBarTitle: Text(
        MyTable.getStringByLocale(
            'List of suppliers', context.read<DataCenter>().locale),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: items.isEmpty
              ? const Icon(
                  MyTable.supplierIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: items.length,
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
                      text: items[index].supplierCode![0],
                    ),
                    title: Text(items[index].supplierCode!),
                    subtitle: Text('${items[index].supplierAddress}'),
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
                  content: Text(MyTable.getStringByLocale(
                      'Supplier added', context.read<DataCenter>().locale)),
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
          'New supplier', context.read<DataCenter>().locale)),
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
                  onSaved: (newValue) => _supplierCode = newValue!,
                  validator: (value) {
                    bool isThere = false;
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
                      }

                      context.read<DataCenter>().supplierList.forEach((item) {
                        if (item.supplierCode!
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
                //if (context.read<DataCenter>().addItemDescriptionField)
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _supplierName = newValue,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Supplier name', context.read<DataCenter>().locale),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _supplierAddress = newValue!,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Supplier address', context.read<DataCenter>().locale),
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
                    labelText: MyTable.getStringByLocale(
                        'Supplier e-mail', context.read<DataCenter>().locale),
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

class MySupplierDetails extends StatelessWidget {
  final int index;
  const MySupplierDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
