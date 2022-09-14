import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';
import 'materials.dart';
import 'mytable.dart';
import 'more.dart';

class Customer extends StatelessWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MyCustomer> items = context.watch<DataCenter>().customerList;
    return MyScaffold(
      addData: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddCustomer(),
          ),
        );
      },
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'List of customers', context.read<DataCenter>().languageCode)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: items.isEmpty
              ? const Icon(
                  MyTable.customerIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCustomerDetails(
                          index: index,
                        ),
                      ),
                    ),
                    leading: MyIcon(
                      text: items[index].customerCode![0],
                    ),
                    title: Text(items[index].customerCode!),
                    subtitle: Text(
                        '${items[index].customerFirstName} ${items[index].customerLastName}'),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddCustomer extends StatelessWidget {
  const AddCustomer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _customerCode,
        _customerFirstName,
        _customerLastName,
        _customerAddress,
        _customerEmail;

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().insertCustomer(
                    MyCustomer.copy(
                      MyCustomer(
                        customerCode: _customerCode,
                        customerFirstName: _customerFirstName,
                        customerLastName: _customerLastName,
                        customerAddress: _customerAddress,
                        customerEmail: _customerEmail,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Customer added',
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
          'New customer', context.read<DataCenter>().languageCode)),
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
                      onSaved: (newValue) => _customerCode = newValue,
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
                              .customerList
                              .forEach((item) {
                            if (item.customerCode!
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
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerFirstName = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('First name',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerLastName = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('Last name',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerAddress = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Address', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => _customerEmail = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'E-mail', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    /*SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(MyTable.getStringByLanguageCode(
                            'Add e-mail field',
                            context.read<DataCenter>().languageCode)),
                        value: _value1,
                        onChanged: (bool value) {
                          setState(() {
                            _value1 = value;
                          });
                        }),
                    SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(MyTable.getStringByLanguageCode(
                            'Add address field',
                            context.read<DataCenter>().languageCode)),
                        value: _value,
                        onChanged: (bool value) {
                          setState(() {
                            _value = value;
                          });
                        }),*/
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

class MyCustomerDetails extends StatelessWidget {
  final int index;
  const MyCustomerDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Object?> customer = {};
    if (index >= context.read<DataCenter>().customerList.length) {
      customer = context.read<DataCenter>().customerList[index - 1].toJson();
    } else {
      customer = context.read<DataCenter>().customerList[index].toJson();
    }

    String customerCode = customer[MyTable.customerCodeField] as String;

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
                      builder: (context) => EditCustomer(
                        index: index,
                      ),
                    ),
                  ),
                );
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
                                '${MyTable.getStringByLanguageCode('Are you sure you want to delete', context.read<DataCenter>().languageCode)} $customerCode',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    context.read<DataCenter>().deleteRow(
                                          MyTable.customer,
                                          MyTable.customerCodeField,
                                          customerCode,
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
        customerCode,
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
                subtitle: Text('${customer[MyTable.customerCodeField]}'),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Code', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Text('${customer[MyTable.customerFirstNameField]}'),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'First name', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Text('${customer[MyTable.customerLastNameField]}'),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Last name', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if ('${customer[MyTable.customerAddressField]}'.isNotEmpty)
                ListTile(
                  subtitle: Text('${customer[MyTable.customerAddressField]}'),
                  title: Text(
                    MyTable.getStringByLanguageCode(
                        'Address', context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if ('${customer[MyTable.customerEmailField]}'.isNotEmpty)
                ListTile(
                  subtitle: Text('${customer[MyTable.customerEmailField]}'),
                  title: Text(
                    MyTable.getStringByLanguageCode(
                        'E-mail', context.read<DataCenter>().languageCode),
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

class EditCustomer extends StatelessWidget {
  final int index;
  const EditCustomer({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    MyCustomer customer = context.read<DataCenter>().customerList[index];
    String? _customerCode,
        _customerFirstName,
        _customerLastName,
        _customerAddress,
        _customerEmail;

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<DataCenter>().updateCustomer(
                    index,
                    MyCustomer.copy(
                      MyCustomer(
                        customerCode: _customerCode,
                        customerFirstName: _customerFirstName,
                        customerLastName: _customerLastName,
                        customerAddress: _customerAddress,
                        customerEmail: _customerEmail,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Customer edited',
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
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'Edit customer', context.read<DataCenter>().languageCode)),
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
                      initialValue: customer.customerCode,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerCode = newValue,
                      validator: (value) {
                        bool isThere = false;
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          List<MyCustomer> items =
                              context.read<DataCenter>().customerList;
                          for (int i = 0; i < items.length; i++) {
                            if (i == index) {
                              continue;
                            }

                            if (items[i]
                                    .customerCode!
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
                      initialValue: customer.customerFirstName,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerFirstName = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('First name',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: customer.customerLastName,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerLastName = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('Last name',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => _customerAddress = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Address', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) => _customerEmail = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'E-mail', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    /*SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(MyTable.getStringByLanguageCode(
                            'Add e-mail field',
                            context.read<DataCenter>().languageCode)),
                        value: _value1,
                        onChanged: (bool value) {
                          setState(() {
                            _value1 = value;
                          });
                        }),
                    SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(MyTable.getStringByLanguageCode(
                            'Add address field',
                            context.read<DataCenter>().languageCode)),
                        value: _value,
                        onChanged: (bool value) {
                          setState(() {
                            _value = value;
                          });
                        }),
                    if (context.read<DataCenter>().addCustomerAddressField)
                  //if ('${customer.customerAddress}'.isNotEmpty)
                  TextFormField(
                    initialValue: customer.customerAddress,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _customerAddress = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Address', context.read<DataCenter>().languageCode),
                    ),
                  ),
                if (context.read<DataCenter>().addCustomerEmailField)
                  //if ('${customer.customerEmail}'.isNotEmpty)
                  TextFormField(
                    initialValue: customer.customerEmail,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => _customerEmail = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'E-mail', context.read<DataCenter>().languageCode),
                    ),
                  ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLanguageCode(
                      'Add e-mail field', context.read<DataCenter>().languageCode)),
                  value: context.read<DataCenter>().addCustomerEmailField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addCustomerEmailField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLanguageCode(
                      'Add address field', context.read<DataCenter>().languageCode)),
                  value: context.read<DataCenter>().addCustomerAddressField,
                  onChanged: (bool value) => context
                      .read<DataCenter>()
                      .addCustomerAddressField = value,
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
