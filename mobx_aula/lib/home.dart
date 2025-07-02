import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_aula/controller.dart';
import 'package:mobx_aula/principal.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }
  
  late Controller _controller;
  ReactionDisposer? reactionDisposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // autorun((_) {
    //   print( _controller.isValid );
    // } );

    // Não é possível recuperar a instância do Provider no initState, então precisa usar didChangeDependencies.
    _controller = Provider.of<Controller>(context);

    reactionDisposer = reaction(
      (_) => _controller.userIsLogged,
      (userIsLogged) {
        if ( userIsLogged ) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => Principal())
          );
        }
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    reactionDisposer!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Observer(
              //     builder: (_) {
              //       return Text(
              //         _controller.counter.toString(),
              //         style: const TextStyle(
              //           color: Colors.black,
              //           fontSize: 80
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email'
                  ),
                  onChanged: ( email ) {
                    _controller.setMail(email);
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha'
                  ),
                  onChanged: ( password ) {
                    _controller.setPassword(password);
                  }
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: Observer(
                  builder: (_) {
                    return Text(
                      _controller.isValid
                        ? 'Válido'
                        : '* campos não validados: ${_controller.mailAndPassword}'
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Observer(
                  builder: (_) {
                    return ElevatedButton(
                      onPressed: _controller.isValid
                        ? () {
                          _controller.login();
                        }
                        : null,
                      child: _controller.isLoading
                        ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white)
                        )
                        : const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}