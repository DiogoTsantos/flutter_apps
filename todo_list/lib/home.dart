import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _todoList = [];
  TextEditingController todoController = TextEditingController();

  Future<File> _getFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  _saveFile() async {
    File file = await _getFile();
    file.writeAsStringSync(json.encode(_todoList));
  }

  _saveTodo() {
    Map<String, dynamic> todo = {};
    todo['title'] = todoController.text;
    todo['status'] = false;
    setState(() {
      _todoList.add(todo);
    });
    _saveFile();
    todoController.text = '';
  }

  _readFile() async {
    try {
      final File file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _readFile().then((data){
      setState(() {
        _todoList = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tarefas'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: _createItemList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Adicionar tarefa'),
                content: TextField(
                  controller: todoController,
                  decoration: const InputDecoration(
                    labelText: 'Descreva a tarefa'
                  ),
                  onChanged: (value) {
                    
                  },
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple
                    ),
                    onPressed: () {
                      _saveTodo();
                      Navigator.pop(context);
                    },
                    child: const Text('Salvar')
                  ),
                ],
              );
            }
          );
        },
        child: const Icon(
          Icons.add
        ),
      ),
    );
  }

  Widget _createItemList(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white)
          ],
        ),
      ),
      onDismissed: (direction) {
        Map<String,dynamic> removedItem = _todoList.removeAt(index);
        _saveFile();

        final snackbar = SnackBar(
          content: const Text('Tarefa removida!'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              setState(() {
                _todoList.insert(index, removedItem);
              });
              _saveFile();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      child: CheckboxListTile(
        title: Text(_todoList[index]['title']),
        value: _todoList[index]['status'],
        onChanged: (value) {
          setState(() {
            _todoList[index]['status'] = value;
          });
          _saveFile();
        },
      ),
    );
  }
}