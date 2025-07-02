import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({super.key});

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation> 
  with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener((status) => _status = status);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: 300,
            height: 400,
            child: RotationTransition(
              turns: _controller,
              alignment: Alignment.center,
              child: Image.asset('images/logo.png'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print(_status);
              if (_status == AnimationStatus.dismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
              // if (_controller.isAnimating) {
              //   _controller.stop();
              // } else {
              //   _controller.repeat();
              // }
            },
            child: const Text('Pressione')
          )
        ]
      ),
    );
  }
}