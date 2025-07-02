import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _tripList = [
    'Praia do Francês',
    'Maragogi',
    'Caldas Novas',
  ];

  _openMap() {

  }

  _removeTrip() {
   setState(() {
     _tripList.removeAt(0);
   });
  }

  _addTrip() { 

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Viagens"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTrip,
        backgroundColor: const Color(0xff0066cc),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tripList.length,
              itemBuilder: (context, index) {
                String title = _tripList[index];
                return GestureDetector(
                  onTap: _openMap(),
                  child: Card(
                    child: ListTile(
                      title: Text(title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _removeTrip,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                );
              }
            )
          ),
        ],
      ),
    );
  }
}