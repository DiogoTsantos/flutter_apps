import 'package:atm_consultoria/template_screen.dart';
import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      screen: 'servicos',
      label: 'Nossos Serviços',
      labelColor: Colors.lightBlue,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '* Consultoria',
            style: TextStyle( fontSize: 18 ),
          ),
          Text(
            '* Palestras',
            style: TextStyle( fontSize: 18 ),
          ),
          Text(
            '* Capacitação de Pessoal',
            style: TextStyle( fontSize: 18 ),
          ),
        ],
      ),
    );
  }
}