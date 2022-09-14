import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';
import 'materials.dart';
import 'mytable.dart';
import 'item.dart';
import 'customer.dart';
import 'sale.dart';
import 'supplier.dart';
import 'command.dart';

class ItemPricesHistory extends StatelessWidget {
  const ItemPricesHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MyItemPriceAtDate> pricesHistory =
        context.read<DataCenter>().itemPriceAtDateList;

    return MyScaffold(
      showFloatingButton: false,
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'Prices history', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: pricesHistory.isEmpty
              ? const Icon(
                  MyTable.itemPriceAtDateIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: pricesHistory.length,
                  itemBuilder: (context, index) => ListTile(
                    onLongPress: () {
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
                                        '${pricesHistory[index].itemCode!} - ${MyTable.formatDateToLanguageCode(context.read<DataCenter>().languageCode, pricesHistory[index].atDate!)} - ${pricesHistory[index].itemPrice}',
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
                                                pricesHistory[index].itemCode!,
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
                    },
                    title: Text(pricesHistory[index].itemCode!),
                    trailing: Text('${pricesHistory[index].itemPrice!}'),
                    subtitle: Text(MyTable.formatDateToLanguageCode(
                        context.read<DataCenter>().languageCode,
                        pricesHistory[index].atDate!)),
                  ),
                ),
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showFloatingButton: false,
      drawer: const MyDrawer(),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        padding: const EdgeInsets.all(15),
        children: [
          MenuWidget(
            subtitle: '${context.watch<DataCenter>().itemList.length}',
            color: Colors.white,
            title: MyTable.getStringByLanguageCode(
                'Items', context.read<DataCenter>().languageCode),
            icon: const Icon(
              MyTable.itemIcon,
              size: 50,
              color: Colors.white,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Item(),
              ),
            ),
          ),
          MenuWidget(
            color: Colors.white,
            title: MyTable.getStringByLanguageCode(
                'Customers', context.read<DataCenter>().languageCode),
            subtitle: '${context.watch<DataCenter>().customerList.length}',
            icon: const Icon(
              MyTable.customerIcon,
              size: 50,
              color: Colors.white,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Customer(),
              ),
            ),
          ),
          MenuWidget(
            color: Colors.white,
            title: MyTable.getStringByLanguageCode(
                'Sales', context.read<DataCenter>().languageCode),
            subtitle: '${context.watch<DataCenter>().saleList.length}',
            icon: const Icon(
              MyTable.saleIcon,
              size: 50,
              color: Colors.white,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Sale(),
              ),
            ),
          ),
          MenuWidget(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Supplier(),
              ),
            ),
            color: Colors.white,
            title: MyTable.getStringByLanguageCode(
                'Suppliers', context.read<DataCenter>().languageCode),
            subtitle: '${context.watch<DataCenter>().supplierList.length}',
            icon: const Icon(
              MyTable.supplierIcon,
              size: 50,
              color: Colors.white,
            ),
          ),
          MenuWidget(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Command(),
              ),
            ),
            color: Colors.white,
            title: MyTable.getStringByLanguageCode(
                'Commands', context.read<DataCenter>().languageCode),
            subtitle: '${context.watch<DataCenter>().commandList.length}',
            icon: const Icon(
              MyTable.commandIcon,
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'Stock & Inventory', context.read<DataCenter>().languageCode),
      ),
    );
  }
}

class Log extends StatelessWidget {
  const Log({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool _securedText = true;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            reverse: true,
            child: Column(
              children: [
                /*Image.asset(
                  'assets/favicon.png',
                  width: 90,
                  height: 90,
                ),*/

                const Icon(
                  Icons.account_box,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 10,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Form(
                    key: _formKey,
                    child: TextFormField(
                      initialValue: 'pie123',
                      validator: (value) {
                        if (value == null || value != 'pie123') {
                          return MyTable.getStringByLanguageCode(
                              'Invalid user code',
                              context.read<DataCenter>().languageCode);
                        }

                        return null;
                      },
                      obscureText: _securedText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_securedText
                              ? Icons.remove_red_eye
                              : Icons.security),
                          onPressed: () => setState(() {
                            _securedText = !_securedText;
                          }),
                        ),
                        labelText: MyTable.getStringByLanguageCode('User code',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeWidget(),
                          ),
                        );
                      }
                    },
                    child: Text(MyTable.getStringByLanguageCode(
                        'Log in', context.read<DataCenter>().languageCode)),
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
