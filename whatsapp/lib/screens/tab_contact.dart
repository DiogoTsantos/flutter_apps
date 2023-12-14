import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/user.dart';

class TabContact extends StatefulWidget {
  const TabContact({super.key});

  @override
  State<TabContact> createState() => _TabContactState();
}

class _TabContactState extends State<TabContact> {
  String? _idUserLogged;
  String? _idUserMail;

  Future<List<UserApp>> _getContacts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection('users')
    .get();

    List<UserApp> userList = [];

    for (QueryDocumentSnapshot item in querySnapshot.docs) {
     final data = item.data() as Map<String, dynamic>?;
      if (data != null && item.id != _idUserLogged ) {
        userList.add(
          UserApp(
            id: item.id,
            name: data['name'],
            urlImage: data.containsKey('urlImage')
              ? data['urlImage']
              : '',
          )
        );
      }
    }

    return userList;
  }

  _recoverUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    _idUserLogged = auth.currentUser!.uid;
    _idUserMail = auth.currentUser!.email;
  }

  @override
  void initState() {
    super.initState();
    _recoverUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserApp>>(
      future: _getContacts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Carregando contatos...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                List<UserApp>? items = snapshot.data;
                UserApp? user = items?[index];
                String name = '';
                String urlImage = '';
                if ( user != null ) {
                  name = user.name;
                  urlImage = user.urlImage;
                }
                return ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: urlImage != ''
                      ? NetworkImage(urlImage)
                      : null
                  ),
                  title: Text(
                    name != ''
                      ? name
                      : 'Não informado',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/messages',
                      arguments: user
                    );
                  },
                );
              },
            );
        }
      },
    );
  }
}