import 'package:flutter/material.dart';

class EntradaCheckbox extends StatefulWidget {
  const EntradaCheckbox({super.key});

  @override
  State<EntradaCheckbox> createState() => _EntradaCheckboxState();
}

class _EntradaCheckboxState extends State<EntradaCheckbox> {
  bool? _comidaBrasileira = false;
  bool? _comidaMexicana = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de dados'),
      ),
      body: Container(
        child: Column(
          children: [
            CheckboxListTile(
              value: _comidaBrasileira,
              onChanged: (bool? valor) {
                setState(() {
                  _comidaBrasileira = valor;
                });
              },
              title: const Text('Comida Brasileira'),
              subtitle: const Text('O melhor do Brasil'),
              secondary: const Icon(Icons.add_box),
            ),
            CheckboxListTile(
              value: _comidaMexicana,
              onChanged: (bool? valor) {
                setState(() {
                  _comidaMexicana = valor;
                });
              },
              title: const Text('Comida Mexicana'),
              subtitle: const Text('O melhor do Mexico'),
              secondary: const Icon(Icons.add_box),
            ),
            ElevatedButton(
              child: const Text(
                'Salvar',
                style: TextStyle( fontSize: 20 ),
              ),
              onPressed: () {
                print('Comida Brasileira: ' + _comidaBrasileira.toString() + ' Comida Mexicana: ' + _comidaMexicana.toString() );
              },
            )
            // const Text('Comida Brasileira'),
            // Checkbox(
            //   value: _checkbox,
            //   onChanged: (bool? valor) {
            //     setState(() {
            //       _checkbox = valor;
            //     });
            //   }
            // )
          ]
        ),
      ),
    );
  }
}