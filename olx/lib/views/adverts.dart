import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/models/advert.dart';
import 'package:olx/util/olx_settings.dart';
import 'package:olx/views/widgets/advert_item.dart';

class Adverts extends StatefulWidget {
  const Adverts({super.key});

  @override
  State<Adverts> createState() => AdvertsState();
}

class AdvertsState extends State<Adverts> {
  List<String> _menuItems = [];
  String? _selectedState;
  String? _selectedCategory;

  List<DropdownMenuItem<String>> _listState = [];
  List<DropdownMenuItem<String>> _listCategories = [];

  final StreamController _controller = StreamController.broadcast();

  _chooseMenuItem(String item) async {
    switch (item) {
      case 'Entrar / Casdastrar':
        Navigator.pushNamed(context, '/login');
        break;
      case 'Meus anúncios':
        Navigator.pushNamed(context, '/my-adverts');
        break;
      case 'Sair':
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.signOut();
        Navigator.pushReplacementNamed(context, '/login');
        break;
    }
  }

  Future _checkLoggedUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      _menuItems = [
        'Entrar / Casdastrar'
      ];
    } else {
      _menuItems = [
        'Meus anúncios',
        'Sair'
      ];
    }
  }

  _loadingItensDropdown() {
    _listState = OlxSettings.getStates();

    _listCategories = OlxSettings.getCategories();
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedUser();

    _loadingItensDropdown();
    _addListenerAdverts();
  }

  Future<Stream<QuerySnapshot>> _filterAdverts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection('adverts');

    if ( _selectedState != null ) {
      query = query.where(
        'state',
        isEqualTo: _selectedState
      );
    }

    if ( _selectedCategory != null ) {
      query = query.where(
        'category',
        isEqualTo: _selectedCategory
      );
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((event) {
      _controller.add(event);
    });
    return stream;
  }


  Future<Stream<QuerySnapshot>> _addListenerAdverts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
      .collection('adverts')
      .snapshots();
    stream.listen((event) {
      _controller.add(event);
    });
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Anúncios',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: _chooseMenuItem,
            itemBuilder: (context) {
              return _menuItems.map((String item) => PopupMenuItem(
                value: item,
                child: Text(item),
              )).toList();
            }
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton<String>(
                        iconEnabledColor: Theme.of(context).primaryColor,
                        value: _selectedState,
                        items: _listState,
                        onChanged: (states) {
                          setState(() {
                            _selectedState = states;
                            _filterAdverts();
                          });
                        },
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black
                        ),
                      )
                    )
                  ),
                ),
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey[200],
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton<String>(
                        iconEnabledColor: Theme.of(context).primaryColor,
                        value: _selectedCategory,
                        items: _listCategories,
                        onChanged: (category) {
                          setState(() {
                            _selectedCategory = category;
                            _filterAdverts();
                          });
                        },
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black
                        ),
                      )
                    )
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: _controller.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: Column(
                        children: [
                          Text('Carregando anúncios...'),
                          CircularProgressIndicator()
                        ],
                      ),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:

                    QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
                    if (querySnapshot.docs.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(25),
                        child: const Text(
                          'Nenhum anúncio encontrado',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }
                    
                    return Expanded(
                      child: ListView.builder(
                        itemCount: querySnapshot.docs.length,
                        itemBuilder: (_, index) {
                          List<DocumentSnapshot> listAdverts = querySnapshot.docs.toList();
                          DocumentSnapshot documentSnapshot = listAdverts[index];
                          Advert advert = Advert.fromDocumentSnapshot(documentSnapshot);

                          return AdvertItem(
                            advert: advert,
                            onTapItem: () {
                              Navigator.pushNamed(
                                context,
                                '/advert-detail',
                                arguments: advert
                              );
                            },
                          );
                        },
                      ),
                    );
                }
              }
            ),
          ],
        ),
      )
    );
  }
}