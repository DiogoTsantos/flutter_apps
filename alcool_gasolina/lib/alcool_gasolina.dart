import 'package:flutter/material.dart';

class AlcoolGasolina extends StatefulWidget {
  const AlcoolGasolina({super.key});

  @override
  State<AlcoolGasolina> createState() => _AlcoolGasolinaState();
}

class _AlcoolGasolinaState extends State<AlcoolGasolina> {

  final TextEditingController _controllerAlcool = TextEditingController();
  final TextEditingController _controllerGasolina = TextEditingController();

  String _resultado = '';

  void _calcularDiferenca() {
    if ( _validaPreco(_controllerAlcool) && _validaPreco(_controllerGasolina) ) {
      double precoAlcool = double.parse( _controllerAlcool.text );
      double precoGasolina = double.parse( _controllerGasolina.text );

      setState(() {
        if ( ( precoGasolina * 0.70 ) >= precoAlcool ) {
          _resultado = 'Melhor abasterce com Álcool';
        } else {
          _resultado = 'Melhor abasterce com Gasolina';
        }
      });
    } else {
      setState(() {
        _resultado = "Número inválido, informe valores maiores que 0, Utilizando ponto(.)";
      });
    }
  }

  bool _validaPreco( TextEditingController field ) {
    bool valid = true;
    if ( null == double.tryParse( field.text ) ) {
      valid = false;
    }
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Álcool ou Gasolina' ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('images/logo.png'),
            const Padding(
              padding: EdgeInsets.only(top: 32.0, bottom: 15),
              child: Text(
                'Saiba qual a melhor opção para abastecimento do seu veículo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText:  'Preço do Álcool, ex: 4.59',
                errorText: _controllerAlcool.text.isEmpty || _validaPreco( _controllerAlcool ) ? null : 'Número inválido'
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 22
              ),
              controller: _controllerAlcool,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Preço da Gasolina, ex: 5.59',
                errorText: _controllerGasolina.text.isEmpty || _validaPreco( _controllerGasolina ) ? null : 'Número inválido'
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 22
              ),
              controller: _controllerGasolina,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: ElevatedButton(
                onPressed: _validaPreco(_controllerAlcool)
                  && _validaPreco(_controllerGasolina)
                    ? _calcularDiferenca
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical:13),
                  textStyle: const TextStyle(
                    fontSize: 20
                  )
                ),
                child: const Text(
                  'Calcular'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _resultado,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}