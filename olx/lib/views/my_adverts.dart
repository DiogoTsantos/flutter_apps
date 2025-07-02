import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/models/advert.dart';
import 'package:olx/views/widgets/advert_item.dart';

class MyAdverts extends StatefulWidget {
  const MyAdverts({super.key});

  @override
  State<MyAdverts> createState() => _MyAdvertsState();
}

class _MyAdvertsState extends State<MyAdverts> {
  final StreamController<QuerySnapshot> _controller = StreamController<QuerySnapshot>.broadcast();
  String? _currentUserID;

 void _addListenerAdverts() {
  _recoveryIdLoggedUser();
    if ( _currentUserID == null ) {
      return;
    }

    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
      .collection('my_adverts')
      .doc(_currentUserID)
      .collection('adverts')
      .snapshots();

    stream.listen((event) {
      _controller.add(event);
    });
  }

  void _recoveryIdLoggedUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    _currentUserID = user?.uid;
  }

  _removeAdvert(String id) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
      .collection('my_adverts')
      .doc(_currentUserID)
      .collection('adverts')
      .doc(id)
      .delete().then((_) {
         db
        .collection('adverts')
        .doc(id)
        .delete();
      });
  }

  @override
  void initState() {
    super.initState();
    _addListenerAdverts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus anúncios'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
        onPressed: (){
          Navigator.pushNamed(context, '/new-advert');
        }
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  children: [
                    Text('Carregando dados...'),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if ( snapshot.hasError ) {
                return const Text('Erro ao carregar anúncios');
              }

              QuerySnapshot querySnapshot = snapshot.data!;

              return ListView.builder(
                itemCount: querySnapshot.docs.length,
                itemBuilder: (_, index) {
                  List<DocumentSnapshot> adverts = querySnapshot.docs.toList();
                  DocumentSnapshot advert = adverts[index];

                  return AdvertItem(
                    advert: Advert.fromDocumentSnapshot(advert),
                    onTapItem: () {
                      Navigator.pushNamed(context, '/edit-advert', arguments: advert);
                    },
                    onTapRemove: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Remover anúncio'),
                            content: const Text('Tem certeza que deseja excluir este anúncio?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _removeAdvert(advert.id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Remover',
                                  style: TextStyle(
                                    color: Colors.red
                                  )
                                ),
                              ),
                            ],
                          );
                        }
                      );
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}