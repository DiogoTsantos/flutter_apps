import 'package:flutter/material.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
          ),
          Expanded(child: Container()),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_checkout_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          const SizedBox(width: 10,),
          OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white
            ),
            child: const Text('Cadastrar')
          ),
          const SizedBox(width: 10,),
          OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.lightGreenAccent,
              foregroundColor: Colors.white
            ),
            child: const Text('Entrar')
          )
        ],
      ),
    );
  }
}