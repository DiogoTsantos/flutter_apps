import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/user.dart';

class MessageList extends StatefulWidget {
  UserApp? contact;
  MessageList( this.contact, {super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _idUserLogged = '';
  String _idUserFriend = '';
  final _controller = StreamController<QuerySnapshot>.broadcast();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recoverUserData();
  }

  _listennerTalk() {
    final stream = db.collection('messages')
      .doc(_idUserLogged)
      .collection(_idUserFriend)
      .orderBy('date', descending: false)
      .snapshots()
      .listen((event) {
        _controller.add(event);
        Timer(
          const Duration(
            seconds: 1
          ),
          () {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          },
        );
      });
  }

  _recoverUserData() {
    FirebaseAuth auth = FirebaseAuth.instance;

    _idUserLogged = auth.currentUser!.uid;
    _idUserFriend = widget.contact!.id;
    _listennerTalk();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
              child: Column(
                children: [
                  Text(
                    'Carregando mensagens...',
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
            QuerySnapshot? querySnapshot = snapshot.data;

            if ( snapshot.hasError ) {
              return const Expanded(
                child: Text('Erro ao carregar dados!')
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount:  querySnapshot!.docs.length,
                  itemBuilder: (context, index) {
          
                    List<DocumentSnapshot> messages = querySnapshot.docs.toList();

                    DocumentSnapshot item = messages[index];

                    Alignment alignment = Alignment.centerRight;
                    Color color = const Color(0xffd2ffa5);
          
                    if ( _idUserLogged != item['idUser']) {
                      alignment = Alignment.centerLeft;
                      color = Colors.white;
                    }
          
                    return Align(
                      alignment: alignment,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: 
                            item['type'] == 'text' 
                            ? Text(
                              item['content'],
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            )
                            : Image.network(
                              item['urlImage'],
                            ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
        }
      }
    );
  }
}