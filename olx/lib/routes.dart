import 'package:flutter/material.dart';
import 'package:olx/models/advert.dart';
import 'package:olx/views/adverts.dart';
import 'package:olx/views/avert_detail.dart';
import 'package:olx/views/login.dart';
import 'package:olx/views/my_adverts.dart';
import 'package:olx/views/new_advert.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const Adverts());
      case '/login':
        return MaterialPageRoute(builder: (context) => const Login());
      case '/my-adverts':
        return MaterialPageRoute(builder: (context) => const MyAdverts());
      case '/new-advert':
        return MaterialPageRoute(builder: (context) => const NewAdvert());
      case '/advert-detail':
        return MaterialPageRoute(
          builder: (context) => AdvertDetail(
            advert: settings.arguments as Advert
          )
        );
      default:
       return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tela não encontrada!'),
        ),
        body: const Center(
          child: Text('O conteúdo não foi encontrado!'),
        ),
      );
    });
  }
}
