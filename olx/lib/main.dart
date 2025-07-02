import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx/routes.dart';
import 'package:olx/views/adverts.dart';

void main() async {
  final ThemeData theme = ThemeData(
    primaryColor: const Color(0xff9c27b0),
    hoverColor: const Color(0xff7b1fa2),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'OLX',
      debugShowCheckedModeBanner: false,
      home: const Adverts(),
      theme: theme,
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    )
  );
}
