import 'package:flutter/material.dart';

class OnTheRise extends StatefulWidget {
  const OnTheRise({super.key});

  @override
  State<OnTheRise> createState() => _OnTheRiseState();
}

class _OnTheRiseState extends State<OnTheRise> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Em alta')
    );
  }
}