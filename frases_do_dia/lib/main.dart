import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp( const PhrasesDay());
}

class PhrasesDay extends StatefulWidget {
  const PhrasesDay({super.key});

  @override
  State<PhrasesDay> createState() => PhrasesDay_State();
}

class PhrasesDay_State extends State<PhrasesDay> {
  final List<String> _phrases = [
    'Raaaaavi!',
    'Dormir é bom para ele!',
    'Quando surge o alvo e verde imponente',
    'Inuyasha Senta!'
  ];

  int _number = Random().nextInt(4);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frases do Dia',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Frases do dia'),
          backgroundColor: Colors.green,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('images/logo.png'),
              Text( _phrases[_number] ),
              ElevatedButton(
                onPressed: () => setState(() {
                  _number = Random().nextInt(4);
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                child: const Text('Nova Frase'),
              )
            ],
          ),
        ),
      ),
    );
  }
}