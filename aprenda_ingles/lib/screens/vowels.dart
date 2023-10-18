import 'package:aprenda_ingles/play_sounds.dart';
import 'package:flutter/material.dart';

class Vowels extends StatelessWidget {
  final PlaySounds _playSounds = PlaySounds();
  Vowels({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: [
        GestureDetector(
          onTap: () {
            _playSounds.play('a.mp3');
          },
          child: Image.asset('assets/images/a.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('e.mp3');
          },
          child: Image.asset('assets/images/e.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('i.mp3');
          },
          child: Image.asset('assets/images/i.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('o.mp3');
          },
          child: Image.asset('assets/images/o.png'),
        ),
         GestureDetector(
          onTap: () {
            _playSounds.play('u.mp3');
          },
          child: Image.asset('assets/images/u.png'),
        ),
      ],
    );
  }
}