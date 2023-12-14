import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _controllerName = TextEditingController();
  File? _perfilImage;
  String _idUserLogged = '';
  bool _uploadingImage = false;
  String? _urlImageRecovered;

  Future _recoveryImage(String from) async {
    XFile? selecteImage;
    if ( 'camera' == from ) {
      selecteImage = await ImagePicker.platform.getImageFromSource(source: ImageSource.camera);
    } else {
      selecteImage = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    }

    setState(() {
      if ( selecteImage != null ) {
        _perfilImage = File( selecteImage.path );
      }
    });
    _uploadImage();
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference rootFolder = storage.ref();
    Reference file = rootFolder
      .child('perfil')
      .child('${_idUserLogged}.jpg');
    UploadTask task = file.putFile(_perfilImage!);

    task.snapshotEvents.listen((event) {
      if (TaskState.running == event.state) {
        setState(() {
          _uploadingImage = true;
        });
      } else if ( TaskState.success == event.state) {
        setState(() {
          _uploadingImage = false;
        });
      }
    });

    task.then((TaskSnapshot snapshot) {
      _recoveryUrlPerfil(snapshot);
    },);
  }

  _recoverUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    _idUserLogged =  auth.currentUser!.uid;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await firestore.collection('users')
    .doc(_idUserLogged)
    .get();

    String? name = snapshot.get('name');
    if ( name != null ) {
      _controllerName.text = name;
    }

    if ( snapshot.get('urlImage') != null ) {
      _urlImageRecovered = snapshot.get('urlImage');
    }
  }

  Future _recoveryUrlPerfil(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _updateImageFirestore( url );

    setState(() {
      _urlImageRecovered = url;
    });
  }

  @override
  void initState() {
    super.initState();
    _recoverUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _uploadingImage
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        children: [
                          Text('Atualizando imagem...'),
                          SizedBox(height: 16),
                          CircularProgressIndicator()
                        ],
                      ),
                  )
                  : Container(),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: 
                    _urlImageRecovered != null
                    ? NetworkImage(_urlImageRecovered!)
                    : null
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _recoveryImage('camera');
                      },
                      child: const Text('Câmera')
                    ),
                    TextButton(
                      onPressed: () {
                        _recoveryImage('gallery');
                      },
                      child: const Text('Galeria')
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
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
                  ),
                ),
                Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 12
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _updateProfileName();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)
                          ),
                          backgroundColor: Colors.green
                        ),
                        child: const Text(
                          'Salvar',
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
    );
  }
  
  void _updateImageFirestore(String url) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection('users')
    .doc(_idUserLogged)
    .update({
      'urlImage' : url
    });
  }

  void _updateProfileName() {
    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection('users')
    .doc(_idUserLogged)
    .update({
      'name' : _controllerName.text
    });
  }
}