import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'more.dart';
import 'model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  late BuildContext _context;
  runZonedGuarded(() {
    runApp(ChangeNotifierProvider<DataCenter>(
      create: (BuildContext context) => DataCenter(),
      builder: (context, Stockmax) {
        _context = context;
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate ,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
          ],
          title: 'Stockmax',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.lightBlue[800],
          ),
          home: const Log(),
        );
      },
    ));
  }, (er, st) {
    print('${er.toString()}\n${st.toString()}');
    _context.read<DataCenter>().flutterError =
        '${er.toString()}\n${st.toString()}';
  });

  /*runZoned(
    () {
      runApp(const Stockmax());
    },
    onError: (error) {
      print('My errors caught: $error.toString()');
    },
    zoneSpecification: new ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, 'Intercepted flutter error :$line');
      },
    ),
  );*/
  //runApp(const Stockmax());
}

/*class Stockmax extends StatelessWidget {
  const Stockmax({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      title: 'Stockmax',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
      ),
      home: const Log(),
    );
  }
}*/

/*
class MyLog extends StatefulWidget {
  const MyLog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyLogState();
}

class _MyLogState extends State<MyLog> {
  int _counter = 0, _acounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Statefull: $_counter'),
            Text('Stateless: $_acounter'),
            ElevatedButton(
              child: const Text(
                'Stateless',
              ),
              onPressed: () => _acounter++,
            ),
            StatefulBuilder(builder: (
              context,
              setState,
            ) {
              return ElevatedButton(
                child: Text(
                  'Statefull: $_counter',
                ),
                onPressed: () => setState(() {
                  _counter++;
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

*/

