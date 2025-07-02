import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autofocus;
  final TextInputType type;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;

  const InputCustom({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.autofocus = false,
    this.type = TextInputType.text,
    this.inputFormatters = const [],
    this.maxLines = 1,
    this.validator,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: type,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6)
        )
      ),
      onSaved: onSaved,
    );
  }
}