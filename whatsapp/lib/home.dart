import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/screens/tab_contact.dart';
import 'package:whatsapp/screens/tab_talk.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<String> _menuItens = [
    'Configurações',
    'Deslogar'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this
    );

    _checkUserLogged();
  }

  _chooseMenuItem(String chooseItem) {
    switch (chooseItem) {
      case 'Configurações':
        Navigator.pushNamed(context, '/settings');
        break;
      case 'Deslogar':
        _logoutUser();
        break;
    }
  }

  _logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      )
    );
  }

  _checkUserLogged() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null ) {
      Future(() {
        Navigator.pushReplacementNamed(
          context,
          '/login'
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Platform.isIOS ? 0 : 4,
        title: const Text('Whatsapp'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton<String>(
            onSelected: _chooseMenuItem,
            itemBuilder: (context) {
              return _menuItens.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item)
                );
              }).toList();
            },
          )
        ],
        bottom: TabBar(
          indicatorColor: Platform.isIOS ? Colors.grey[200] : Colors.white,
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          tabs: const [
            Tab(text: 'Conversas'),
            Tab(text: 'Contatos'),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TabTalk(),
          TabContact(),
        ],
      ),
    );
  }
}