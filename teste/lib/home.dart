import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'counter_model_changenotifier.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // CounterModel counterModel = CounterModel();
  CounterModel counterModel = CounterModel();

  @override
  void initState() {
    super.initState();
    print('Start');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (context) {
                return Text(
                  '${counterModel.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            // ListenableBuilder(
            //   listenable: counterModel,
            //   builder: (context, child) {
            //     return Text(
            //     '${counterModel.counter}',
            //     style: Theme.of(context).textTheme.headlineMedium,
            //   );
            //   },
            // )
            ValueListenableBuilder<int>(
              valueListenable: counterModel.counter,
              builder: (context, value, child) {
                 return Text(
                  '${value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterModel.incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}