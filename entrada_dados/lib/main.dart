import 'package:data_input/entradaSlider.dart';
import 'package:data_input/entradaSwitch.dart';
import 'package:data_input/entradacheckbox.dart';
import 'package:data_input/entradaradiobutton.dart';
import 'package:flutter/material.dart';
// import 'campotexto.dart';

void main() {
  runApp(
    const MaterialApp(
      // home: CampoTexto()
      // home: EntradaCheckbox()
      // home: EntradaRadioButton()
      home: EntradaSwitch()
      // home: EntradaSlider()
    )
  );
}