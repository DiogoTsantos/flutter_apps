import 'package:atm_consultoria/template_screen.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      screen: 'contato',
      label: 'Canais de Atendimento',
      labelColor: Colors.green,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '* Telfone: (79) 9 9999-9999',
            style: TextStyle( fontSize: 18 ),
          ),
          SizedBox( height: 10 ),
          Text(
            '* E-mail: contato@atmconsultoria.com.br',
            style: TextStyle( fontSize: 18 ),
          ),
          SizedBox( height: 10 ),
          Text(
            '* site: https://atmconsultoria.com.br',
            style: TextStyle( fontSize: 18 ),
          ),
        ],
      )
    );
  }
}