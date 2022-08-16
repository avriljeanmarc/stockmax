import 'package:flutter/material.dart';
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
                  MyTable.itemIcon,
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
                    leading: MyIcon(text: commands[index].itemCode![0]),
                    title: Text(commands[index].itemCode!),
                    subtitle: commands[index].itemQuantity! <= 100
                        ? Text(
                            '${commands[index].itemQuantity}',
                            style: const TextStyle(color: Colors.red),
                          )
                        : Text(
                            '${commands[index].itemQuantity}',
                            style: const TextStyle(color: Colors.green),
                          ),
                  ),
                ),
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
    // TODO: implement build
    throw UnimplementedError();
  }
}
