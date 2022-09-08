import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_material.dart';
import 'data_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const Stockmax());

class Stockmax extends StatelessWidget {
  const Stockmax({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataCenter>(
      create: (BuildContext context) => DataCenter(),
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          //Locale('zh', 'CH'),
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        title: 'Stockmax',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          /*textTheme: const TextTheme(
            /*headline6: TextStyle(
              fontSize: 25.0,
            ),*/
            bodyText2: TextStyle(
              fontSize: 20.0,
            ),
            subtitle1: TextStyle(
              fontSize: 18.0,
            ),
          ),*/
        ),
        home: const Log(),
      ),
    );
  }
}

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


class Stockmax extends StatelessWidget {
  const Stockmax({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterViewModel>(
      create: (BuildContext context) => CounterViewModel(),
      child: MaterialApp(
        //debugShowCheckedModeBanner: false,
        title: 'Stockmax',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ), //ThemeData.dark(),
        home: const MyLog(), //Log(),
      ),
    );
  }
}
*/

/*
class MyLog extends StatelessWidget {
  const MyLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyTitle',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: ${Provider.of<CounterViewModel>(context).counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'AnotherCounter: ${Provider.of<CounterViewModel>(context).anotherCounter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              child: const Text(
                'Increment anotherCounter',
              ),
              onPressed: Provider.of<CounterViewModel>(context, listen: false)
                  .incrementAnotherCounter,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<CounterViewModel>(context, listen: false)
            .incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int _anotherCounter = 0;

  int get counter => _counter;
  int get anotherCounter => _anotherCounter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void incrementAnotherCounter() {
    _anotherCounter++;
  }
}
*/