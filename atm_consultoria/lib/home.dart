import 'package:atm_consultoria/company.dart';
import 'package:atm_consultoria/contact.dart';
import 'package:atm_consultoria/customer.dart';
import 'package:atm_consultoria/service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _openSoucePage( Widget source, BuildContext context ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => source
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATM Consultoria'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            Image.asset('imagens/logo.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Image.asset('imagens/menu_empresa.png'),
                    onTap: () => _openSoucePage(const Company(), context)
                  ),
                  GestureDetector(
                    child: Image.asset('imagens/menu_servico.png'),
                    onTap: () {
                      _openSoucePage(const Service(), context);
                    },
                  )
                  ,
                ],
              ),
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Image.asset('imagens/menu_cliente.png'),
                  onTap: () {
                    _openSoucePage(const Customer(), context);
                  },
                ),
                GestureDetector(
                  child: Image.asset('imagens/menu_contato.png'),
                  onTap: () {
                    _openSoucePage(const Contact(), context);
                  },
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}