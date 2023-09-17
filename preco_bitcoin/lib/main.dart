import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preco_biticoin/preco_bitcoin.dart';

void main() {
  runApp(
    const MaterialApp(
      home:  PrecoBitcoin(),
      debugShowCheckedModeBanner: false,
    )
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]
  );
}

