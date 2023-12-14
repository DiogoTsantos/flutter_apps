import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/talk.dart';
import 'package:whatsapp/model/user.dart';

class TabTalk extends StatefulWidget {
  const TabTalk({super.key});

  @override
  State<TabTalk> createState() => _TabTalkState();
}

class _TabTalkState extends State<TabTalk> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUserLogged = '';
  FirebaseFirestore db =  FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    _recoverUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  _listennerTalk() {
    final stream = db.collection('talks')
      .doc(_idUserLogged)
      .collection('last_talk')
      .snapshots()
      .listen((event) {
        _controller.add(event);
      });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
              child: Column(
                children: [
                  Text(
                    'Carregando conversas...',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  const CircularProgressIndicator()
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if ( snapshot.hasError ) {
              return const Expanded(
                child: Text('Erro ao carregar dados!')
              );
            } else {
              QuerySnapshot? querySnapshot = snapshot.data;
              if ( querySnapshot!.docs.isEmpty ) {  
                return const Center(
                  child: Text(
                    'Nenhum conversa disponível',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> talks = querySnapshot.docs.toList();

                    DocumentSnapshot talk = talks[index];

                    UserApp user = UserApp(
                      id: talk['idRecipient'],
                      name: talk['name'],
                      urlImage: talk['imagePath']
                    );

                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/messages',
                          arguments: user
                        );
                      },
                      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: talk['imagePath'] != null
                          ? NetworkImage(talk['imagePath'])
                          : null,
                      ),
                      title: Text(
                        talk['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      subtitle: Text(
                        talk['messageType'] == 'text'
                          ? talk['message']
                          : 'Imagem',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                        ),
                      ),
                    );
                  },
                );
              }
            }
        }
      }
    );
  }

  _recoverUserData() {
    FirebaseAuth auth = FirebaseAuth.instance;

    _idUserLogged = auth.currentUser!.uid;
    _listennerTalk();
  }
}