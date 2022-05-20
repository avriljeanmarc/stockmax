import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart';
import 'sale.dart';
import 'item.dart';
import 'customer.dart';
import 'mytable.dart';
import 'supplier.dart';
import 'package:badges/badges.dart';

class MyIcon extends StatelessWidget {
  final String text;
  const MyIcon({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Center(
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title, subtitle;
  const MyCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/favicon.png'),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(subtitle),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text("PLAY"),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextButton(
                            child: const Text("ADD TO QUEUE"),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int index;
  const MyBottomNavigationBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      //onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.article,
          ),
          label: 'Articles',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.contacts,
          ),
          label: 'Clients',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.request_quote,
          ),
          label: 'Ventes',
        ),
      ],
    );
  }
}

class MyScaffold extends StatelessWidget {
  final Widget child;
  final Widget appBarTitle;
  final VoidCallback? addData;
  final bool showFloatingButton;
  final bool showActionsButton;
  final MyDrawer? drawer;
  final MyBottomNavigationBar? bottomNavigationBar;
  final List<Widget>? actions;
  const MyScaffold({
    Key? key,
    required this.appBarTitle,
    required this.child,
    this.addData,
    this.showFloatingButton = true,
    this.showActionsButton = false,
    this.drawer,
    this.bottomNavigationBar,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      appBar: AppBar(
        actions: showActionsButton ? actions : null,
        centerTitle: true,
        title: appBarTitle,
      ),
      body: SafeArea(
        child: child,
      ),
      floatingActionButton: showFloatingButton
          ? FloatingActionButton(
              onPressed: addData,
              child: const Icon(
                Icons.add,
              ),
            )
          : null,
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showFloatingButton: false,
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListTile(
                title: Text(MyTable.getStringByLocale(
                    'Customize items data', context.read<DataCenter>().locale)),
                trailing: const Icon(
                  MyTable.customizeDataIcon,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ItemSettings(),
                  ),
                ),
              ),
              ListTile(
                title: Text(MyTable.getStringByLocale(
                    'Customize customers data',
                    context.read<DataCenter>().locale)),
                trailing: const Icon(
                  MyTable.customizeDataIcon,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerSettings(),
                  ),
                ),
              ),
              ListTile(
                title: Text(MyTable.getStringByLocale(
                    'Customize sales data', context.read<DataCenter>().locale)),
                trailing: const Icon(
                  MyTable.customizeDataIcon,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaleSettings(),
                  ),
                ),
              ),
              ListTile(
                onTap: () => context.read<DataCenter>().deleteDatabase(),
                tileColor: Colors.red,
                title: const Text('Delete database'),
                leading: const Icon(
                  Icons.delete,
                ),
              )
            ],
          )),
      appBarTitle: Text(
        context.read<DataCenter>().locale == 'US'
            ? 'Settings'
            : 'Param\u00E8tres',
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color? color;
  final VoidCallback? onTap;

  const MenuWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Badge(
        showBadge: subtitle != '0' ? true : false,
        badgeContent: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        child: Container(
          /*decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            /*border: Border.all(
              color: Colors.red,
            ),*/
          ),*/
          color: Colors.blue,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            bottom: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 200,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Stockmax 1.0.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(
              Icons.settings,
            ),
            title: Text(MyTable.getStringByLocale(
                'Settings', context.read<DataCenter>().locale)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 3,
          ),
          ListTile(
            title: Text(context.read<DataCenter>().locale == 'US'
                ? MyTable.getStringByLocale('French', 'FR')
                : MyTable.getStringByLocale('English', 'US')),
            trailing: const Icon(
              Icons.language,
            ),
            onTap: () {
              context.read<DataCenter>().locale == 'US'
                  ? context.read<DataCenter>().locale = 'FR'
                  : context.read<DataCenter>().locale = 'US';
              Navigator.pop(context);
            },
          ),
        ],
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
            subtitle: '${context.read<DataCenter>().itemList.length}',
            color: Colors.white,
            title: MyTable.getStringByLocale(
                'Items', context.watch<DataCenter>().locale),
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
            title: MyTable.getStringByLocale(
                'Customers', context.read<DataCenter>().locale),
            subtitle: '${context.read<DataCenter>().customerList.length}',
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
            title: MyTable.getStringByLocale(
                'Sales', context.read<DataCenter>().locale),
            subtitle: '${context.read<DataCenter>().saleList.length}',
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
            title: MyTable.getStringByLocale(
                'Suppliers', context.read<DataCenter>().locale),
            subtitle: '${context.read<DataCenter>().supplierList.length}',
            icon: const Icon(
              MyTable.supplierIcon,
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
      appBarTitle: Text(
        MyTable.getStringByLocale(
            'Stock & inventory', context.read<DataCenter>().locale),
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
                          return MyTable.getStringByLocale('Invalid user code',
                              context.watch<DataCenter>().locale);
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
                        labelText: MyTable.getStringByLocale(
                            'User code', context.watch<DataCenter>().locale),
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
                    child: Text(MyTable.getStringByLocale(
                        'Log in', context.watch<DataCenter>().locale)),
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
