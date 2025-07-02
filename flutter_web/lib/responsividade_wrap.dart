import 'package:flutter/material.dart';

class ResponsividadeWrap extends StatelessWidget {
  const ResponsividadeWrap({super.key});

  @override
  Widget build(BuildContext context) {
    double largura = 600;
    double altura = 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wrap'),
      ),
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 10,
          runSpacing: 10,
          children: [
            Container(
              width: largura,
              height: altura,
              color: Colors.orange,
            ),
             Container(
              width: largura,
              height: altura,
              color: Colors.blueGrey,
            ),
            Container(
              width: largura,
              height: altura,
              color: Colors.green,
            ),
            Container(
              width: largura,
              height: altura,
              color: Colors.red[200],
            ),
            Container(
              width: largura,
              height: altura,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}