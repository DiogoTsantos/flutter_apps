import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ishow/button_animated.dart';
import 'package:ishow/custom_input.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationBlur;
  late Animation<double> _animationFade;
  late Animation<double> _animationSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500) 
    );

    _animationBlur = Tween<double>(
      begin: 5.0,
      end: 0.0
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease
    ));

    _animationFade = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    ));

    _animationSize = Tween<double>(
      begin: 0.0,
      end: 500
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _animationBlur,
              builder: (context, child) {
                return Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/fundo.png"),
                      fit: BoxFit.fill
                    )
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: _animationBlur.value,
                      sigmaY: _animationBlur.value
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          child: FadeTransition(
                            opacity: _animationFade,
                            child: Image.asset("images/detalhe1.png"),
                          )
                        ),
                        Positioned(
                          left: 50,
                          child: FadeTransition(
                            opacity: _animationFade,
                            child: Image.asset("images/detalhe2.png"),
                          )
                        )
                      ]
                    ),
                  )
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animationSize,
                    builder: (context, child) {
                      return Container(
                        width: _animationSize.value,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1
                            )
                          ]
                        ),
                        child: const Column(
                          children: [
                            CustomInput(
                              hint: 'E-mail',
                              obscure: false,
                              icon: Icon( Icons.person )
                            ),
                            CustomInput(
                              hint: 'Senha',
                              obscure: true,
                              icon: Icon( Icons.lock )
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 20,),
                  ButtonAnimated(
                    controller: _controller
                  ),
                  const SizedBox(height: 20,),
                  FadeTransition(
                    opacity: _animationFade,
                    child: const Text(
                      'Esqueci minha senha!',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 100, 127, 1),
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}