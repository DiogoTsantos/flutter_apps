import 'package:aprenda_ingles/play_sounds.dart';
import 'package:flutter/material.dart';

class Animals extends StatelessWidget {
  final PlaySounds _playSounds = PlaySounds();
  Animals({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: [
        GestureDetector(
          onTap: () {
            _playSounds.play('cao.mp3');
          },
          child: Image.asset('assets/images/cao.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('gato.mp3');
          },
          child: Image.asset('assets/images/gato.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('leao.mp3');
          },
          child: Image.asset('assets/images/leao.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('macaco.mp3');
          },
          child: Image.asset('assets/images/macaco.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('ovelha.mp3');
          },
          child: Image.asset('assets/images/ovelha.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('vaca.mp3');
          },
          child: Image.asset('assets/images/vaca.png'),
        )
      ],
    );
  }
}