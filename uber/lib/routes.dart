import 'package:flutter/material.dart';
import 'package:uber/screen/dash_driver.dart';
import 'package:uber/screen/dash_passenger.dart';
import 'package:uber/screen/travel.dart';

import 'screen/home.dart';
import 'screen/register.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    MaterialPageRoute next;
    final args = settings.arguments;
    switch (settings.name) {
      case '/register':
        next = MaterialPageRoute(builder: (context) => const Register());
        break;
      case '/':
        next = MaterialPageRoute(builder: (context) => const Home());
        break;
      case '/passenger':
        next = MaterialPageRoute(builder: (context) => const DashPassenger());
        break;
      case '/driver':
        next = MaterialPageRoute(builder: (context) => const DashDriver());
        break;
      case '/travel':
        next = MaterialPageRoute(builder: (context) => Travel(
          args.toString()
        ));
        break;
      default:
        next = _errorRoute();
    }
    return next;
  }

  static MaterialPageRoute<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Falha'),
          ),
          body: const Center(
            child: Text('Desculpe! Página não encontra.'),
          ),
        );
    });
  }
}