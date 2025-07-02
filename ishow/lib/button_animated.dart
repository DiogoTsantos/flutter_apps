import 'package:flutter/material.dart';

class ButtonAnimated extends StatelessWidget {
  ButtonAnimated({super.key, required this.controller}) : 
    _width = Tween<double>(
      begin: 0,
      end: 500
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5)
    )),
    _opacity = Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.6, 0.8)
    ));

  AnimationController controller;
  Animation<double> _width;
  Animation<double> _opacity;

  Widget _buildAnimatation( BuildContext context, Widget? child) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        height: 50,
        width: _width.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 100, 127, 1),
              Color.fromRGBO(255, 123, 145, 1)
            ]
          )
        ),
        child: Center(
          child: FadeTransition(
            opacity: _opacity,
            child: const Text(
              'Entrar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.controller,
      builder: (context, child) {
        return _buildAnimatation(context, child);
      }
    );
  }
}