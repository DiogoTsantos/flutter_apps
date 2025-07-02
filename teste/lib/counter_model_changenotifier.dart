import 'package:flutter/material.dart';

// class CounterModel extends ChangeNotifier {
//   int _counter = 0;

//   int get counter => _counter;

//   void incrementCounter() {
//     _counter++;
//     notifyListeners();
//   }
// }

class CounterModel {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  void incrementCounter() {
    counter.value++;
  }
}