import 'package:flutter/material.dart';
import 'package:mobx_aula/controller.dart';
import 'package:mobx_aula/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => Controller()
        ),
      ],
      child: const MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    )
  );
}
