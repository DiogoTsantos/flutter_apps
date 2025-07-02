import 'package:animations/basic_animation.dart';
import 'package:animations/implicit_animation.dart';
import 'package:animations/more_animation.dart';
import 'package:animations/tween_animation.dart';
import 'package:flutter/material.dart';

import 'explicit_animation.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MoreAnimation(),
      debugShowCheckedModeBanner: false,
    )
  );
}
