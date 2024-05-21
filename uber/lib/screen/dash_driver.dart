import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/utils/firebase_user.dart';
import 'package:uber/utils/travel_status.dart';

class DashDriver extends StatefulWidget {
  const DashDriver({super.key});

  @override
  State<DashDriver> createState() => _DashDriverState();
}

class _DashDriverState extends State<DashDriver> {
  final List<String> _menuItems = [
    'Configurações',
    'Sair'
  ];

  final _controller = StreamController<QuerySnapshot>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  _logoutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
      context,
      '/'
    );
  }
  _choosenMenuItem(String value) {
    if (value == 'Sair') {
      _logoutUser();
    }
  }

  _addListennerTravels() {
    db.collection('travels')
      .where('status', isEqualTo: TravelStatus.AGUARDANDO)
      .snapshots().asBroadcastStream().listen((event) {
        _controller.add(event);
      });
  }

  _recoveryActiveTravel() async {
    User? firebaseUser = await FirebaseUser.getCurrentUser();

    DocumentSnapshot snapshot = await db.collection('travels_active_driver')
      .doc(firebaseUser!.uid).get();
    
    if ( snapshot.data() == null ) {
      _addListennerTravels();
    } else {
      var data = snapshot.data() as Map<String, dynamic>;

      Navigator.pushReplacementNamed(
        context,
        '/travel',
        arguments: data['id']
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recoveryActiveTravel();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingMessage = const Center(
      child: Column(
        children: [
          Text('Carregando corridas...'),
          CircularProgressIndicator()
        ],
      ),
    );

    Widget emptyData = const Center(
      child: Text(
        'Nenhuma corrida disponível...',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Motorista'),
        actions: [
          PopupMenuButton(
            onSelected: _choosenMenuItem,
            itemBuilder: (context) {
              return _menuItems.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item)
                );
              }).toList();
            }
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return loadingMessage;
            case ConnectionState.active:
            case ConnectionState.done:
              if ( snapshot.hasError ) {
                return const Text('Falha ao carregar os dados!');
              } else {
                QuerySnapshot querySnapshot = snapshot.data!;
                if ( querySnapshot.docs.isEmpty ) {
                  return emptyData;
                } else {
                  return ListView.separated(
                    itemCount: querySnapshot.docs.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[500],
                      height: 2,
                    ),
                    itemBuilder: (context, index) {
                      List<DocumentSnapshot> documents = querySnapshot.docs;
                      DocumentSnapshot item = documents[index];

                      String? travelId = item['id'];
                      String namePassenger = item['passenger']['name'];
                      String street = item['destination']['street'];
                      String number = item['destination']['number'];
                      
                      return ListTile(
                        title: Text(namePassenger),
                        subtitle: Text("Destino: ${street}, ${number}"),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/travel',
                            arguments: travelId
                          );
                        }
                      );
                    },
                  );
                }
              }
          }
        },
      ),
    );
  }
}