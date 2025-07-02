import 'package:flutter/material.dart';

class MoreAnimation extends StatefulWidget {
  const MoreAnimation({super.key});

  @override
  State<MoreAnimation> createState() => _MoreAnimationState();
}

class _MoreAnimationState extends State<MoreAnimation>
  with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    // _animation = Tween(
    //   begin: 0.0,
    //   end: 1.0
    // ).animate(_animationController);

    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(60, 60)
    ).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _animationController.forward();
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _animation,
        child: Stack(
          children: [
            Positioned(
              width: 180,
              height: 180,
              left: 0,
              top: 0,
              child: Image.asset('images/logo.png')
            )
          ],
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: _animation.value,
            child: child,
          );
          // return Transform.scale(
          //   scale: 1.0 * _animation.value,
          //   child: child,
          // );
        },
      ),
    );
  }
}