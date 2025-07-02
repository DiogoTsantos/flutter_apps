import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_aula/controller.dart';
import 'package:mobx_aula/item_controller.dart';
import 'package:mobx_aula/principal_controller.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  PrincipalController _principalController = PrincipalController();

  _dialog(){
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: const Text("Adicionar item"),
            content: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Digite uma descrição..."
              ),
              onChanged: _principalController.setNewItem,
            ),
            actions: [
              TextButton(
                  onPressed: (){ Navigator.pop(context); },
                  child: const Text("Cancelar", style: TextStyle(
                    color: Colors.red
                  ),)
              ),
              TextButton(
                onPressed: (){
                  _principalController.addItem();
                  Navigator.pop(context);
                },
                child: const Text("Salvar")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final Controller controller = Provider.of<Controller>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tarefas do ${controller.mail}',
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _principalController.items.length,
            itemBuilder: (_, indice){
              ItemlController item = _principalController.items[indice];
              return Card(
                color: Colors.white,
                shadowColor: Colors.blue,
                surfaceTintColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Observer(
                  builder: (_) {
                    return ListTile(
                      title: Text(
                        item.title,
                        style: TextStyle(
                          decoration: item.checked ? TextDecoration.lineThrough : null
                        ),
                      ),
                      leading: Checkbox(
                        value: item.checked,
                        onChanged: item.changeChecked,
                      ),
                      onTap: (){
                          item.checked = !item.checked;
                      },
                    );
                  }
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          _dialog();
        },
      ),
    );
  }
}
