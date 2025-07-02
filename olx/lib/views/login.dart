import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/models/users.dart';
import 'package:olx/views/widgets/button_custom.dart';
import 'package:olx/views/widgets/input_custom.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _registerMode = false;
  final TextEditingController _emailController = TextEditingController(text: 'diogo@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '123456');

  String _errorMessage = '';

  _validFields() {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (_emailController.text.isNotEmpty
      && regex.hasMatch(_emailController.text)
      && _passwordController.text.isNotEmpty
      && _passwordController.text.length >= 6) {

      Users user = Users(
        email: _emailController.text,
        password: _passwordController.text
      );
      if ( _registerMode ) {
        _registerUser( user );
      } else {
        _loginUser( user );
      }
    } else {
      setState(() {
        _errorMessage = 'E-mail ou senha inválidos!';
      });
    }
  }

  _registerUser( Users user ) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text
    ).then((value) {
      Navigator.pushReplacementNamed(
        context,
        '/'
      );
    });
  }

  _loginUser( Users user ) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text
    ).then((value) => Navigator.pushReplacementNamed(
      context,
      '/'
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'images/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                InputCustom(
                  controller: _emailController,
                  hintText: 'E-mail',
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputCustom(
                  controller: _passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Logar'),
                    Switch(
                      value: _registerMode,
                      onChanged: (value) {
                        setState(() {
                          _registerMode = value;
                        });
                      }
                    ),
                    const Text('Cadastrar')
                  ],
                ),
                ButtonCustom(
                  text: _registerMode ? 'Cadastrar' : 'Entrar',
                  onPressed: _validFields
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Ir para anúncios')
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}