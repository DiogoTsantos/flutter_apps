import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/mixins/auth_validation.dart';
import 'package:whatsapp/model/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with AuthValidations {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _registerUser( UserApp user) {
    _auth.createUserWithEmailAndPassword(
      email: user.mail,
      password: user.pass ?? ''
    ).then((firebaseUser) {
      _firestore.collection('users')
      .doc(firebaseUser.user!.uid)
      .set(
        user.toMap()
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (_) => false
      );
    }).catchError((error){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Falha ao criar usuário'),
            content: Text(error.toString() ),
          );
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo usuário'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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
                      'images/usuario.png',
                      height: 150,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      controller: _controllerName,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontSize: 20
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Nome do Usuário',
                        errorStyle: TextStyle(
                          color: Colors.orangeAccent
                        )
                      ),
                      validator: (value) => validName(value),
                    ),
                  ),
                  TextFormField(
                    controller: _controllerMail,
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
                  const SizedBox( height: 8,),
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
                        if (_formKey.currentState!.validate() ) {
                            _registerUser(
                              UserApp(
                                name: _controllerName.text,
                                mail: _controllerMail.text,
                                pass: _controllerPass.text,
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
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}