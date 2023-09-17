import 'package:flutter/material.dart';

class ResultGame extends StatelessWidget {
  int cara_coroa; 
  ResultGame(this.cara_coroa, {super.key});

  @override
  Widget build(BuildContext context) {
    Image result;

    if ( 1 == cara_coroa ) {
      result = Image.asset('images/moeda_cara.png');
    } else {
      result = Image.asset('images/moeda_coroa.png');
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(97, 189, 140, 1),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            result,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('images/botao_voltar.png')
            )
          ],
        )
      )
    );
  }
}