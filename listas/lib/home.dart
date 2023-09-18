import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _itens = [];

  void _carregarItens() {
    if ( _itens.isNotEmpty ) {
      return;
    }

    for (int i = 0; i < 10; i++) {
      Map<String, dynamic> item = {
        'titulo': 'Título ${i} Lorem ipsum dolor sit amet',
        'descricao': 'Descrição ${i} Lorem ipsum dolor sit amet',
      };
      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarItens();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _itens.length,
          itemBuilder: (context, indice) {
            // print( _itens[indice]['titulo']  );
            return ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(_itens[indice]['titulo']),
                      titlePadding: const EdgeInsets.all(20),
                      titleTextStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.green
                      ),
                      content: Text(_itens[indice]['descricao']),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              print('Remover ${indice}');
                              _itens.removeAt(indice);
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red
                          ),
                          child: const Text('Remover'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar')
                        ),
                      ],
                    );
                  }
                );
              },
              title: Text( _itens[indice]['titulo'] ),
              subtitle: Text( _itens[indice]['descricao']),
            );
          },
        ),
      ),
    );
  }
}