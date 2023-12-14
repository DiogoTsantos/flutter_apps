import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/mixins/auth_validation.dart';
import 'package:whatsapp/model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with AuthValidations{
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _loginUser(UserApp user) {
    _auth.signInWithEmailAndPassword(
      email: user.mail,
      password: user.pass ?? ''
    ).then((firebaseUser) {
      Navigator.pushReplacementNamed(
        context,
        '/home'
      );
    }).catchError((error){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Falha na Autenticação'),
            content: Text(error.toString() ),
          );
        }
      );
    });
  }

  _checkUserLogged() {
    User? user = _auth.currentUser;

    if (user != null ) {
      Future(() {
        Navigator.pushReplacementNamed(
          context,
          '/home'
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserLogged();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff075e54)
        ),
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                      'images/logo.png',
                      height: 150,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      controller: _controllerMail,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontSize: 20
                      ),
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                        errorStyle: TextStyle(
                          color: Colors.orangeAccent
                        )
                      ),
                      validator: (value) => validMail(value),
                    ),
                  ),
                  TextFormField(
                    controller: _controllerPass,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                      errorStyle: TextStyle(
                        color: Colors.orangeAccent
                      )
                    ),
                    validator: (value) => validPass(value),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 12
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                         _loginUser(
                          UserApp(
                            mail: _controllerMail.text,
                            pass: _controllerPass.text
                          )
                         );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                        ),
                        backgroundColor: Colors.green
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/register'
                        );
                      },
                      child: const Text(
                        'Não tem conta? Casdastre-se!',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}