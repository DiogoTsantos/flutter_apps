import 'dart:ffi';

import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Tela'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: ElevatedButton(
          child: const Text('Ir para página inicial'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}