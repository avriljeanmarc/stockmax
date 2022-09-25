import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        context.watch<DataCenter>().itemPriceAtDateList;

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
                  itemBuilder: (context, index) => Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: ((context) {
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
                                              /*Text(
                                                '${pricesHistory[index].itemCode!} - ${MyTable.formatDateToLanguageCode(context.read<DataCenter>().languageCode, pricesHistory[index].atDate!)} - ${pricesHistory[index].itemPrice}',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),*/
                                            ]),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  context
                                                      .read<DataCenter>()
                                                      .deleteItemPriceAtDate(
                                                        pricesHistory[index]
                                                            .itemCode!,
                                                        pricesHistory[index]
                                                            .atDate!,
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
                            }),
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                            onPressed: ((context) {}),
                            //backgroundColor: Colors.white,

                            icon: Icons.close,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(pricesHistory[index].itemCode!),
                        trailing: Text('${pricesHistory[index].itemPrice!}'),
                        subtitle: Text(MyTable.formatDateToLanguageCode(
                            context.read<DataCenter>().languageCode,
                            pricesHistory[index].atDate!)),
                      )),
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

class ImportExcelSheet extends StatelessWidget {
  const ImportExcelSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> myList = MyTable.menuList;
    return MyScaffold(
      showFloatingButton: false,
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'Import excel sheet', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => import(index, context),
              title: Text(MyTable.getStringByLanguageCode(
                  myList[index], context.read<DataCenter>().languageCode)),
            ),
          ),
        ),
      ),
    );
  }

  void import(int index, BuildContext context) async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv', 'xls'],
    );

    if (file != null && file.files.isNotEmpty) {
      Uint8List bytes = File(file.files.first.path!).readAsBytesSync();
      Excel excel = Excel.decodeBytes(bytes);
      List<Map<String, Object?>> excelSheet = [];

      for (String sheetName in excel.tables.keys) {
        if (index == 0) {
          for (List<Data?> row in excel.tables[sheetName]?.rows ?? []) {
            excelSheet.add({
              MyTable.itemCodeField: row[0]?.value ?? '',
              MyTable.itemQuantityField:
                  double.tryParse((row[1]?.value ?? 0.0).toString()),
              MyTable.itemDescriptionField: row[2]?.value ?? '',
              MyTable.itemUnitField: row[3]?.value ?? '',
              MyTable.itemCategoryField: row[4]?.value ?? '',
              MyTable.itemQualityField: row[5]?.value ?? '',
            });
          }

          for (var json in excelSheet) {
            context.read<DataCenter>().insertItem(MyItem.fromJson(json));
          }
        }
        if (index == 1) {
          for (List<Data?> row in excel.tables[sheetName]?.rows ?? []) {
            excelSheet.add({
              MyTable.customerCodeField: row[0]?.value ?? '',
              MyTable.customerFirstNameField: row[1]?.value ?? '',
              MyTable.customerLastNameField: row[2]?.value ?? '',
              MyTable.customerAddressField: row[3]?.value ?? '',
              MyTable.customerEmailField: row[4]?.value ?? '',
            });
          }

          for (var json in excelSheet) {
            context
                .read<DataCenter>()
                .insertCustomer(MyCustomer.fromJson(json));
          }
        }
        if (index == 2) {
          for (List<Data?> row in excel.tables[sheetName]?.rows ?? []) {
            excelSheet.add({
              MyTable.supplierCodeField: row[0]?.value ?? '',
              MyTable.supplierNameField: row[1]?.value ?? '',
              MyTable.supplierAddressField: row[2]?.value ?? '',
              MyTable.supplierEmailField: row[3]?.value ?? '',
            });
          }

          for (var json in excelSheet) {
            context
                .read<DataCenter>()
                .insertSupplier(MySupplier.fromJson(json));
          }
        }
      }
    }
  }
}

class ExportExcelSheet extends StatelessWidget {
  const ExportExcelSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> myList = MyTable.menuList;
    return MyScaffold(
      showFloatingButton: false,
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'Import excel sheet', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => export(index, context),
              title: Text(MyTable.getStringByLanguageCode(
                  myList[index], context.read<DataCenter>().languageCode)),
            ),
          ),
        ),
      ),
    );
  }

  void export(int index, BuildContext context) async {}
}
