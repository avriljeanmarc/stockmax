import 'package:flutter/material.dart';
import 'data_model.dart';
import 'package:provider/provider.dart';
import 'custom_material.dart';
import 'mytable.dart';

class CustomerSettings extends StatelessWidget {
  const CustomerSettings({Key? key}) : super(key: key);

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
          'Customers data', context.read<DataCenter>().locale)),
      child: Column(
        children: [
          SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add e-mail field', context.read<DataCenter>().locale)),
            value: context.watch<DataCenter>().addCustomerEmailField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addCustomerEmailField = value,
          ),
          SwitchListTile(
            title: Text(MyTable.getStringByLocale(
                'Add address field', context.read<DataCenter>().locale)),
            value: context.read<DataCenter>().addCustomerAddressField,
            onChanged: (bool value) =>
                context.read<DataCenter>().addCustomerAddressField = value,
          ),
        ],
      ),
    );
  }
}

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
      appBarTitle: Text(MyTable.getStringByLocale(
          'List of customers', context.read<DataCenter>().locale)),
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
                  content: Text(MyTable.getStringByLocale(
                      'Customer added', context.read<DataCenter>().locale)),
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
          'New customer', context.read<DataCenter>().locale)),
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
                  onSaved: (newValue) => _customerCode = newValue,
                  validator: (value) {
                    bool isThere = false;
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
                      }

                      context.read<DataCenter>().customerList.forEach((item) {
                        if (item.customerCode!
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
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _customerFirstName = newValue,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'First name', context.read<DataCenter>().locale),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _customerLastName = newValue,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'Last name', context.read<DataCenter>().locale),
                  ),
                ),
                if (context.read<DataCenter>().addCustomerAddressField)
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _customerAddress = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Address', context.read<DataCenter>().locale),
                    ),
                  ),
                if (context.read<DataCenter>().addCustomerEmailField)
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => _customerEmail = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'E-mail', context.read<DataCenter>().locale),
                    ),
                  ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLocale(
                      'Add e-mail field', context.read<DataCenter>().locale)),
                  value: context.watch<DataCenter>().addCustomerEmailField,
                  onChanged: (bool value) =>
                      context.read<DataCenter>().addCustomerEmailField = value,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(MyTable.getStringByLocale(
                      'Add address field', context.read<DataCenter>().locale)),
                  value: context.read<DataCenter>().addCustomerAddressField,
                  onChanged: (bool value) => context
                      .read<DataCenter>()
                      .addCustomerAddressField = value,
                ),
              ],
            ),
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
    Map<String, Object?> item = {};
    if (index >= context.read<DataCenter>().customerList.length) {
      item = context.read<DataCenter>().customerList[index - 1].toJson();
    } else {
      item = context.read<DataCenter>().customerList[index].toJson();
    }

    String customerCode = item[MyTable.customerCodeField] as String;

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
                                '${MyTable.getStringByLocale('Are you sure you want to delete', context.read<DataCenter>().locale)} $customerCode',
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
                MyTable.getStringByLocale(
                    'Delete', context.read<DataCenter>().locale),
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
                title: Text(
                  '${MyTable.getStringByLocale('Code', context.read<DataCenter>().locale)}: ${item[MyTable.customerCodeField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('First name', context.read<DataCenter>().locale)}: ${item[MyTable.customerFirstNameField]}',
                ),
              ),
              ListTile(
                title: Text(
                  '${MyTable.getStringByLocale('Last name', context.read<DataCenter>().locale)}: ${item[MyTable.customerLastNameField]}',
                ),
              ),
              if ('${item[MyTable.customerAddressField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('Address', context.read<DataCenter>().locale)}: ${item[MyTable.customerAddressField]}',
                  ),
                ),
              if ('${item[MyTable.customerEmailField]}'.isNotEmpty)
                ListTile(
                  title: Text(
                    '${MyTable.getStringByLocale('E-mail', context.read<DataCenter>().locale)}: ${item[MyTable.customerEmailField]}',
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
                  content: Text(MyTable.getStringByLocale(
                      'Customer edited', context.read<DataCenter>().locale)),
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
          'Edit customer', context.read<DataCenter>().locale)),
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
                  initialValue: customer.customerCode,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _customerCode = newValue,
                  validator: (value) {
                    bool isThere = false;
                    if (value != null) {
                      if (value.isEmpty) {
                        return MyTable.getStringByLocale('Field is required',
                            context.read<DataCenter>().locale);
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
                TextFormField(
                  initialValue: customer.customerFirstName,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (newValue) => _customerFirstName = newValue,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: MyTable.getStringByLocale(
                        'First name', context.read<DataCenter>().locale),
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
                    labelText: MyTable.getStringByLocale(
                        'Last name', context.read<DataCenter>().locale),
                  ),
                ),
                if (context.read<DataCenter>().addCustomerAddressField)
                  TextFormField(
                    initialValue: customer.customerAddress,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => _customerAddress = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'Address', context.read<DataCenter>().locale),
                    ),
                  ),
                if (context.read<DataCenter>().addCustomerEmailField)
                  TextFormField(
                    initialValue: customer.customerEmail,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => _customerEmail = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLocale(
                          'E-mail', context.read<DataCenter>().locale),
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
