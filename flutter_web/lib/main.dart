import 'package:flutter/material.dart';
import 'package:flutter_web/loja_virtual.dart';
import 'package:flutter_web/regras_layout.dart';
import 'package:flutter_web/responsividade_media_query.dart';
import 'package:flutter_web/responsividade_row_column.dart';
import 'package:flutter_web/orientation.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter WEB',
      home: const LojaVirtual(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white
        )
      ),
    )
  );
}
