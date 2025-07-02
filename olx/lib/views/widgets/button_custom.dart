import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.onPressed
  });

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      onPressed: onPressed,
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      color: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20
        )
      ),
    );
  }
}