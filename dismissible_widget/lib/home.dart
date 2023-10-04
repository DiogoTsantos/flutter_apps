import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _names = ['Ravi', 'Rosa', 'Diogo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _names.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(16),
                child: const Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              // direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                if ( direction == DismissDirection.endToStart ) {
                  print(direction.toString());
                }
                setState(() {
                  _names.removeAt(index);
                });
              },
              key: Key(_names[index]),
              child: ListTile(
                title: Text(_names[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}