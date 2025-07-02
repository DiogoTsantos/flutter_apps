import 'package:flutter/material.dart';

class TeenAnimation extends StatefulWidget {
  const TeenAnimation({super.key});

  @override
  State<TeenAnimation> createState() => _TeenAnimationState();
}

class _TeenAnimationState extends State<TeenAnimation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      /*child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 6.28),
        duration: Duration(seconds: 2),
        builder: (context, angle, child) {
          return Transform.rotate(
            angle: angle,
            child: Image.asset('images/logo.png'),
          );
        }
      ),*/

      child: TweenAnimationBuilder(
        tween: ColorTween(begin: Colors.white, end: Colors.orange),
        duration: Duration(seconds: 3),
        child: Image.asset('images/estrelas.jpg'),
        builder: (context, Color? color, child) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(
              color!,
              BlendMode.overlay
            ),
            child: child
          );
        }
      ),
    );
  }
}