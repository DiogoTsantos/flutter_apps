import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _contact = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _foneController = TextEditingController();
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Manipulação de dados' ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              _contact,
              style: const TextStyle(
                fontSize: 20
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome'
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                controller: _foneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addContact,
                  child: const Text('Salvar')
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _displayContact,
                    child: const Text('Exibir')
                  ),
                ),
                ElevatedButton(
                  onPressed: _removeContact,
                  child: const Text('Remover')
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _displayContact() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = await prefs.getString('name');
    setState(() {
      if ( name != null ) {
        _contact = "Nome: ${prefs.getString('name')} Telefone: ${prefs.getString('fone')}";
      } else {
        _contact = 'Nenhum contao encontrado.';
      }
    });
  }

  _removeContact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('fone');
    _displayContact();
  }
  
  _addContact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('fone', _foneController.text);
    _displayContact();
  }
}