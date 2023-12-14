import 'package:flutter/material.dart';
import 'package:whatsapp/home.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/messages.dart';
import 'package:whatsapp/model/user.dart';
import 'package:whatsapp/register.dart';
import 'package:whatsapp/settings.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute( RouteSettings settings ) {
    dynamic nextRoute;
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        nextRoute = const Login();
        break;
      case '/login':
        nextRoute = const Login();
        break;
      case '/register':
        nextRoute = const Register();
        break;
      case '/home':
        nextRoute = const Home();
        break;
      case '/settings':
        nextRoute = const Settings();
        break;
      case '/messages':
        if ( args is UserApp) {
          nextRoute = Messages(
            args
          );
        } else {
         nextRoute = _errorRoute();
        }
        break;
      default:
        nextRoute = _errorRoute();
    }

    return MaterialPageRoute(
      builder: (_) => nextRoute,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Tela não encontrada'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Tela não encontrada!'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(_, '/home');
                },
                child: const Text('Home')
              )
            ]
          ),
        ),
      ),
    );
  }
}