import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class PrecoBitcoin extends StatefulWidget {
  const PrecoBitcoin({super.key});

  @override
  State<PrecoBitcoin> createState() => _PrecoBitcoinState();
}

class _PrecoBitcoinState extends State<PrecoBitcoin> {

  _PrecoBitcoinState () {
    _updateCotation();
  }

  String _currentPrice = '';
  final _dio = Dio();

  void _updateCotation() async {
    Response response = await _dio.get('https://blockchain.info/ticker');
    setState(() {
      if ( response.data['BRL']['last'] != null ) {
        _currentPrice = NumberFormat.simpleCurrency(locale: 'pt_BR').format(response.data['BRL']['last']);
      } else {
        _currentPrice = 'Preço indisponível';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/bitcoin.png',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                _currentPrice,
                style: const TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _updateCotation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Atualizar',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}