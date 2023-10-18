import 'package:aprenda_ingles/play_sounds.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Numbers extends StatelessWidget {
  final PlaySounds _playSounds = PlaySounds();
  Numbers({super.key});

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: [
        GestureDetector(
          onTap: () {
            _playSounds.play('1.mp3');
          },
          child: Image.asset('assets/images/1.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('2.mp3');
          },
          child: Image.asset('assets/images/2.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('3.mp3');
          },
          child: Image.asset('assets/images/3.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('4.mp3');
          },
          child: Image.asset('assets/images/4.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('5.mp3');
          },
          child: Image.asset('assets/images/5.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('6.mp3');
          },
          child: Image.asset('assets/images/6.png'),
        )
      ],
    );
  }
}