import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          padding: const EdgeInsets.all(20),
          width: _status ? 200 : 300,
          height: _status ? 200 : 300,
          color: _status ? Colors.purpleAccent : Colors.white,
          duration: const Duration(seconds: 2),
          curve: Curves.elasticInOut,
          child: Image.asset('images/logo.png'),
        ),
        ElevatedButton(
          onPressed: (){
            setState(() {
              _status = !_status;
            });
          },
          child: const Text('Alterar')
        )
      ],
    );
  }
}