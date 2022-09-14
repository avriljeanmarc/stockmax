import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'mytable.dart';
import 'package:badges/badges.dart';
import 'more.dart';

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
        MyTable.getStringByLanguageCode(
            'Settings', context.read<DataCenter>().languageCode),
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
            title: Text(MyTable.getStringByLanguageCode(
                'Settings', context.read<DataCenter>().languageCode)),
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
            trailing: const Icon(
              Icons.attach_money,
            ),
            title: Text(MyTable.getStringByLanguageCode('View prices history',
                context.read<DataCenter>().languageCode)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ItemPricesHistory(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 3,
          ),
          ListTile(
            title: Text(context.read<DataCenter>().languageCode == 'en'
                ? MyTable.getStringByLanguageCode('French', 'fr')
                : MyTable.getStringByLanguageCode('English', 'en')),
            trailing: const Icon(
              Icons.language,
            ),
            onTap: () {
              if (context.read<DataCenter>().languageCode == 'en') {
                context.read<DataCenter>().languageCode = 'fr';
              } else {
                context.read<DataCenter>().languageCode = 'en';
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
