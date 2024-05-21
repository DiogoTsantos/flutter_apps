import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  String _errorMessage = '';
  bool _loading = false;

  _validForm() {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    if ( _controllerMail.text.isEmpty
      ||  _controllerPass.text.isEmpty
      || ! RegExp(pattern).hasMatch(_controllerMail.text ) ) {
      setState(() {
        _errorMessage = 'E-mail e/ou senha inválidos!';
      });
      return false;
    }

    return true;
  }

  _login() {
    setState(() {
      _loading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: _controllerMail.text,
      password: _controllerPass.text
    ).then((value) {
      _redirectUserToDash(value.user!.uid);
    }).catchError((value) {
      setState(() {
        _errorMessage = 'Falha no autenticar usuário, verifique os dados e tente novamente!';
      });
    });
  }

  _redirectUserToDash(String idUser) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db.collection('users').doc(idUser).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    setState(() {
      _loading = false;
    });
    if (data['type'] == 'motorista') {
      Navigator.pushReplacementNamed(context, '/driver');
    } else if (data['type'] == 'passageiro') {
      Navigator.pushReplacementNamed(context, '/passenger');
    }
  }

  _checkUserLogged() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if ( auth.currentUser != null ) {
      _redirectUserToDash(auth.currentUser!.uid);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fundo.png'),
            fit: BoxFit.cover
          )
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset('images/logo.png', height: 150, width: 200,),
                ),
                TextField(
                  controller: _controllerMail,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  obscureText: true,
                  controller: _controllerPass,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff1ebbd8),
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    ),
                    onPressed: () {
                      if ( _validForm() ) {
                        _login();
                      }
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
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
                      "Não tem conta? Cadastre-se",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                ),
                _loading
                  ? const Center( child: CircularProgressIndicator() )
                  : Container(),
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
        ),
      ),
    );
  }
}