import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class OlxSettings {
  static List<DropdownMenuItem<String>> getCategories() {
    List<DropdownMenuItem<String>> list = [];

    list.add(
      const DropdownMenuItem<String>(
        value: null,
        child: Text(
          'Categoria',
          style: TextStyle(
            color: Color(0xff9c27b0)
          ),
        )
      ),
    );

    list.add(
      const DropdownMenuItem<String>(
        value: 'auto',
        child: Text('Automóvel')
      ),
    );

    list.add(
      const DropdownMenuItem<String>(
        value: 'imovel',
        child: Text('Imóvel')
      ),
    );

    list.add(
      const DropdownMenuItem<String>(
        value: 'eletro',
        child: Text('Eletrônicos')
      ),
    );

    list.add(
      const DropdownMenuItem<String>(
        value: 'esportes',
        child: Text('Esportes')
      ),
    );

    list.add(
      const DropdownMenuItem<String>(
        value: 'moda',
        child: Text('Moda')
      ),
    );

    return list;
  }

  static List<DropdownMenuItem<String>> getStates() {
    List<DropdownMenuItem<String>> list = [];

    list.add(
      const DropdownMenuItem<String>(
        value: null,
        child: Text(
          'Região',
          style: TextStyle(
            color: Color(0xff9c27b0)
          ),
        )
      ),
    );

    for (var state in Estados.listaEstadosSigla) {
      list.add(
        DropdownMenuItem<String>(
          value: state,
          child: Text(state)
        )
      );
    }
    return list;
  }
}