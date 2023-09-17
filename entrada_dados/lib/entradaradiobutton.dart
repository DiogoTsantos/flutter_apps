import 'package:flutter/material.dart';

class EntradaRadioButton extends StatefulWidget {
  const EntradaRadioButton({super.key});

  @override
  State<EntradaRadioButton> createState() => _EntradaRadioButtonState();
}

class _EntradaRadioButtonState extends State<EntradaRadioButton> {

  String? _escolharUsuario = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de dados'),
      ),
      body: Container(
        child: Column(
          children: [
            RadioListTile(
              value: 'm',
              groupValue: _escolharUsuario,
              onChanged: (String? valor) {
                setState(() {
                  _escolharUsuario = valor;
                });
              },
              title: const Text('Masculino'),
            ),
            RadioListTile(
              value: 'f',
              groupValue: _escolharUsuario,
              onChanged: (String? valor) {
                setState(() {
                  _escolharUsuario = valor;
                });
              },
              title: const Text('Feminio'),
            ),
            ElevatedButton(
              onPressed: () {
                print( "Escolha do Usuário: ${_escolharUsuario}");
              },
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 20),
              )
            )
            // const Text('Masculino'),
            // Radio(
            //   value: 'm',
            //   groupValue: _escolharUsuario,
            //   onChanged: (String? valor) {
            //     setState(() {
            //       _escolharUsuario = valor;
            //     });
            //   }
            // ),
            // const Text('Feminino'),
            // Radio(
            //   value: 'f',
            //   groupValue: _escolharUsuario,
            //   onChanged: (String? valor) {
            //     setState(() {
            //       _escolharUsuario = valor;
            //     });
            //   }
            // )
          ]
        ),
      ),
    );
  }
}