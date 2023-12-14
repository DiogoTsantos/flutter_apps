import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/routes.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final ThemeData defaultTheme = ThemeData(
    primaryColor: const Color(0xff075e54),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(
          width: 3,
          color: Color(0xff25D366)
        ),
      ),
    ),
  );

  final ThemeData iosTheme = defaultTheme.copyWith(
    primaryColor: Colors.grey[200]
  );
  runApp(MaterialApp(
    home: const Login(),
    theme: Platform.isIOS ? iosTheme : defaultTheme,
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: RoutesGenerator.generateRoute,
  ));
}
