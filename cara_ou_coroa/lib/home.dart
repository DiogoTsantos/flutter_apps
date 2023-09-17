import 'dart:math';

import 'package:cara_ou_coroa/result_game.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffe0e0e0),
      backgroundColor: const Color.fromRGBO(97, 189, 140, 1),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            const SizedBox( height: 25 ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultGame( Random().nextInt(2) )
                  )
                );
              },
              child: Image.asset('images/botao_jogar.png')
            )
          ],
        ),
      ),
    );
  }
}