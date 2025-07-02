import 'package:flutter/material.dart';

class RegrasLayout extends StatelessWidget {
  const RegrasLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regras de Layout'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;

            if ( width < 600 ) {
              return Container(
                child: Text('Celular: $width'),
              );
            } else if ( width < 900 ) {
              return Text('Tablet');
            } else {
              return Container(
                child: Text('PC: $width'),
              );
            }
          },
        ),
      ),
    );
  }
}