import 'package:flutter/material.dart';

class EntradaSwitch extends StatefulWidget {
  const EntradaSwitch({super.key});

  @override
  State<EntradaSwitch> createState() => _entradaSwitchState();
}

class _entradaSwitchState extends State<EntradaSwitch> {

  bool _escolharUsuario = false;
  bool _escolharConfig = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de dados'),
      ),
      body: Container(
        child: Column(
          children: [
            SwitchListTile(
              value: _escolharUsuario,
              onChanged: (bool valor) {
                setState(() {
                  _escolharUsuario = valor;
                });
              },
              title: Text('Receber Notificações?'),
              subtitle: Text('teste'),
              secondary: Icon(Icons.add_box),
            ),
            SwitchListTile(
              value: _escolharConfig,
              onChanged: (bool valor) {
                setState(() {
                  _escolharConfig = valor;
                });
              },
              title: Text('Carregar Imagens Automaticamente?'),
            ),
            ElevatedButton(
              onPressed: () {
                print( "Escolha do Usuário: ${_escolharUsuario} Config: ${_escolharConfig}");
              },
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 20),
              )
            ),
            Switch(
              value: _escolharUsuario,
              onChanged: (bool valor) {
                setState(() {
                  _escolharUsuario = valor;
                });
              }
            ),
            Text('Receber Notificações?')
          ]
        ),
      ),
    );
  }
}