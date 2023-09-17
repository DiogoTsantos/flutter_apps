import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = '';
  final TextEditingController _cep = TextEditingController();

  void _recuperaCep() async {
    if ( _cep.text.length != 8 ) {
      _resultado = 'O CEP informado é inválido';
      return;
    }

    Uri endpoint = Uri.parse('https://viacep.com.br/ws/${_cep.text}/json/');

    http.Response response = await http.get(endpoint);
    Map<String, dynamic> address = json.decode(response.body);

    print(address);
    setState(() {
      if ( address['logradouro'] != '' ) {
        _resultado = "${address['logradouro']}, ${address['complemento']}, ${address['bairro']}";
      } else if ( address['localidade'] != '' )  {
        _resultado = "Cidade: ${address['localidade']}, Habitantes: ${address['ibge']}";
      } else {
        _resultado = 'Não encontrado';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localiza Endereços'),
        backgroundColor: Colors.lightGreen,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Encontre seu endereço usando CEP:',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                controller: _cep,
                decoration: const InputDecoration(
                  labelText: 'Informe seu CEP',
                ),
                keyboardType: TextInputType.number,
                maxLength: 8,
              ),
            ),
            ElevatedButton.icon(
                  onPressed:_recuperaCep,
                  label: const Text('Localizar'),
                  icon: const Icon(
                    Icons.find_in_page
                  )
                ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                _resultado,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}