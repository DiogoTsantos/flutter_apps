import 'package:flutter/material.dart';
import 'package:navegacao/home.dart';
import 'package:navegacao/secondScreen.dart';

void main() {
  runApp( MaterialApp(
    home: const MyWidget(),
    initialRoute: '/',
    routes: {
      '/secundaria' : (context) => SecondScreen()
    },
  ) );
}