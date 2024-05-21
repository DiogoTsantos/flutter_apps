import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/routes.dart';
import 'package:uber/screen/home.dart';

void main() async {

  final ThemeData themeDefault = ThemeData(
    primaryColor: const Color(0xff374747),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff374747),
      foregroundColor: Colors.white,
    )
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: themeDefault,
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    )
  );
}
