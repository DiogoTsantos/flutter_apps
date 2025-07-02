import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
 final TextStyle _styleText = const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold
  );

  AssetImage _imageDefault = const AssetImage( 'images/padrao.png' );
  String _resultGame = 'Escolha uma opção abaixo:';

  void _optionSelected( String choose ) {
    List<String> options = [
      'pedra', 'papel', 'tesoura'
    ];

    int number = Random().nextInt(3);

    setState(() {
      _imageDefault = AssetImage("images/${options[number]}.png" );
      if ( ( 'pedra' == choose && 'tesoura' == options[number] )
        || ( 'tesoura' == choose && 'papel' == options[number] )
        || ( 'papel' == choose && 'pedra' == options[number] ) ) {
        _resultGame = 'Você ganhou! :D';
      } else if ( choose == options[number] ) {
        _resultGame = 'Empate! :|';
      } else {
        _resultGame = 'Você perdeu :(';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'JokenPo' ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              'Escolha do App:',
              style: _styleText,
            ),
            const SizedBox(
              height: 20,
            ),
            Image(image: _imageDefault,),
            const SizedBox(
              height: 20,
            ),
            Text(
              _resultGame,
              style: _styleText,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => _optionSelected('pedra'),
                  child:  Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Image.asset(
                      width: 100,
                      'images/pedra.png'
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _optionSelected('papel'),
                  child:  Image.asset(
                    width: 100,
                    'images/papel.png'
                  ),
                ),
                GestureDetector(
                  onTap: () => _optionSelected('tesoura'),
                  child:  Image.asset(
                    width: 100,
                    'images/tesoura.png'
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}