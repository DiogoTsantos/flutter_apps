import 'package:flutter/material.dart';
import 'package:navegacao/secondScreen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primeira tela'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: ElevatedButton(
          child: const Text('Ir para próxima tela'),
          onPressed: () {
            Navigator.pushNamed(context, '/secundaria');
          },
        ),
      ),
    );
  }
}