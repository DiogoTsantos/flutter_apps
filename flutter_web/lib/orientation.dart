import 'package:flutter/material.dart';

class OrientationScreen extends StatelessWidget {
  const OrientationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orientation'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: [
              Container( color: Colors.red, ),
              Container( color: Colors.blue, ),
              Container( color: Colors.green, ),
              Container( color: Colors.pink, ),
              Container( color: Colors.black, ),
              Container( color: Colors.grey, ),
            ],
          );
        },
      ),
    );
  }
}