import 'package:flutter/material.dart';

class TemplateScreen extends StatelessWidget {
  final String screen;
  final String label;
  final Color labelColor;
  final Widget child;
  TemplateScreen({
    required this.screen,
    required this.label,
    required this.labelColor,
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${screen[0].toUpperCase()}${screen.substring(1)}"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(
                    "imagens/detalhe_$screen.png",
                    width: 85,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: labelColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox( height: 20 ),
              child
            ]
          )
        ),
    );
  }
}