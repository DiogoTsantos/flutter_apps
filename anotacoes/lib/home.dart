import 'package:anotacoes/helper/anotation_helper.dart';
import 'package:anotacoes/model/anotation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final AnotationHelper _db = AnotationHelper();
  List<Anotation> _anotatios = [];

  _displayRegister({Anotation? anotation}) {
    String textSaveEdit = '';

    if ( anotation == null ) {
      _titleController.clear();
      _contentController.clear();
      textSaveEdit = 'Salvar';
    } else {
      _titleController.text = '${anotation.title}';
      _contentController.text = '${anotation.description}';
      textSaveEdit = 'Atualizar';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$textSaveEdit anotação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Digite um título'
                ),
              ),
              TextField(
                controller: _contentController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição'
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar')
            ),
            TextButton(
              onPressed: () {
                _saveUpdateAnotation(anotation: anotation);
                Navigator.pop(context);
              },
              child: Text(textSaveEdit)
            )
          ],
        );
      },
    );
  }

  _saveUpdateAnotation({Anotation? anotation}) {
    if ( anotation == null ) {
      _db.saveAnotation(
        Anotation(
          title: _titleController.text,
          description: _contentController.text,
          createData: DateTime.now().toString()
        )
      );
    } else {
      anotation.title = _titleController.text;
      anotation.description = _contentController.text;
      anotation.createData = DateTime.now().toString();
       _db.updateAnotation(
        anotation
      );
    }
    _titleController.clear();
    _contentController.clear();

    _recoveryAnotations();
  }

  _recoveryAnotations() async {
    List recoveryAnotations = await _db.getAnotations();
    List<Anotation> tempAnotations = [];
    for (var item in recoveryAnotations) {
      tempAnotations.add(Anotation.fromMap(item));
    }

    setState(() {
      _anotatios = tempAnotations;
    });
    tempAnotations = [];
  }

  @override
  void initState() {
    super.initState();
    _recoveryAnotations();
  }

  _dateFormat( String? date ) {
    if ( date != null ) {
      initializeDateFormatting( 'pt_BR');
      DateFormat format = DateFormat.yMMMd('pt_BR');
      DateTime dateTime = DateTime.parse(date);
      date = format.format(dateTime);
    }
    return date;
  }

  _removeAnotation( int id, int index ) {
    _db.removeAnotation(id);
    setState(() {
      _anotatios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _anotatios.length,
              itemBuilder: (context, index) {
                final Anotation anotation = _anotatios[index];
                return Card(
                  child: ListTile(
                    title: Text('${anotation.title}'),
                    subtitle: Text('${_dateFormat(anotation.createData)} - ${anotation.description}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _displayRegister(anotation: anotation);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.greenAccent,
                          )
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirma remoção da anotação?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancelar')
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _removeAnotation(anotation.id!, index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok')
                                  )
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: _displayRegister,
        child: const Icon(Icons.add),
      ),
    );
  }
}