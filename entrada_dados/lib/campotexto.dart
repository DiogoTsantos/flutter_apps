import 'dart:ffi';

import 'package:flutter/material.dart';

class CampoTexto extends StatefulWidget {
  const CampoTexto({super.key});

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Entrada de dados' ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(32),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite um valor",
                labelStyle: TextStyle(
                  color: Colors.blue
                ),
              ),
              style: const TextStyle(
                fontSize: 35
              ),
              obscureText: true,
              onSubmitted: (String text){
                print(text);
              },
              controller: _textEditingController,
            ),
          ),
          ElevatedButton(
            onPressed: () => print('Valor enviado = ' + _textEditingController.text),
            child: const Text('Salvar')
          )
        ],
      ),
    );
  }
}