import 'package:atm_consultoria/template_screen.dart';
import 'package:flutter/material.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      screen: 'clientes',
      label: 'Clientes',
      labelColor: Colors.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('imagens/cliente1.png'),
              const Text( '- Empresa de Software',
                style: TextStyle(
                  fontSize: 16
                ),
              )
            ],
          ),
          Row(
            children: [
              Image.asset('imagens/cliente2.png'),
              const Text(
                '- Empresa de auditoria',
                style: TextStyle(
                  fontSize: 16
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}