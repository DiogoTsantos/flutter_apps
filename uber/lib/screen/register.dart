import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/uber_user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String _errorMessage = '';

  bool _userType = false;

  _validForm() {
    String error = '';
    if (_nameController.text.isEmpty ) {
      error = 'Preencha o campo Nome!';
    }

    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    if ( error.isEmpty
      && ( _mailController.text.isEmpty
      || ! RegExp(pattern).hasMatch(_mailController.text ) ) ) {
      error = 'Campo E-mail inválido!';
    }

    if ( error.isEmpty
      && ( _passController.text.isEmpty
      || _passController.text.length < 6 ) ) {
      error = 'O Campo Senha precisa ter no mínimo 6 caracteres!';
    }

    if ( error.isNotEmpty ) {
      setState(() {
        _errorMessage = error;
      });
      return false;
    }
    return true;
  }

  _registerUser() {
    UberUser user = UberUser(
      name: _nameController.text,
      email: _mailController.text,
      password: _passController.text,
      type: _userType ? 'motorista' : 'passageiro'
    );

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!
    ).then((value) {
      db.collection('users')
        .doc(value.user!.uid).set(
          user.toMap()
      );

      if ( user.type == 'motorista' ) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/driver',
          (_) => false
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/passenger',
          (_) => false
        );
      }
    }).catchError((value) {
      setState(() {
        _errorMessage = 'Falha no cadastro do usuário, verifique os dados e tente novamente!';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadrastro',
          // style: TextStyle(
          //   color: Colors.white
          // ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  keyboardType: TextInputType.name,
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _mailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    const Text(
                      'Passageiro'
                    ),
                    Switch(
                      value: _userType,
                      onChanged: (value) {
                        setState(() {
                          _userType = value;
                        });
                      }
                    ),
                    const Text(
                      'Motorista'
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff1ebbd8)),
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(32, 16, 32, 16)),
                    ),
                    onPressed: () {
                      if ( _validForm() ) {
                        _registerUser();
                      }
                    },
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20
                      ),
                    ),
                  ),
                )
            ]
          ),
        ),
      )
    );
  }
}