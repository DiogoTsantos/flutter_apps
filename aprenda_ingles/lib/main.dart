import 'package:aprenda_ingles/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Home(),
    theme: ThemeData(
      primaryColor: const Color(0xff795548),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff795548)),
      scaffoldBackgroundColor: const Color(0xfff5e9b9)
    ),
  ));
}
