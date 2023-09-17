import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {
  const EntradaSlider({super.key});

  @override
  State<EntradaSlider> createState() => _EntradaSliderState();
}

class _EntradaSliderState extends State<EntradaSlider> {

  double _progress = 0;
  String label = 'Valor Selecionado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de dados'),
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Column(
          children: [
            Slider(
              value: _progress,
              min: 0,
              max: 10,
              label: label,
              divisions: 5,
              activeColor: Colors.green,
              onChanged: (double progress) {
                setState(() {
                  _progress = progress;
                  label = "Valor Selecionado ${_progress}";
                });
              }
            ),
            ElevatedButton(
              onPressed: () {
                print( "Progress: ${_progress}%");
              },
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 20),
              )
            )
          ]
        ),
      ),
    );
  }
}