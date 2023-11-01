import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

/// Add or update document.
///
/// FirebaseFirestore db instance  from db.
replaceDocument( FirebaseFirestore db ) {
  db.collection('usuarios').doc('001')
  .set({
    'nome': "Diogo",
    'Idade': 31
  });
}

addDocument( FirebaseFirestore db ) async {
  DocumentReference ref = await db.collection('noticias')
  .add({
    'title': "Palmeiras próximos jogos",
    'description': "Palmeiras deve enfretar na quarta-feita..."
  });
}

updateDocument( FirebaseFirestore db ){
  db.collection('noticias')
  .doc('bRJlF4NhIsQRJucL8x1V')
  .update({
    'title': "Palmeiras próximos jogos",
    'description': "Palmeiras deve enfretar na quarta-feita..."
  });
}

deleteDocument( FirebaseFirestore db, String doc ) async {
  db.collection('noticias')
  .doc(doc)
  .delete();
}

getDocument( FirebaseFirestore db, String doc ) async {
  return await db.collection('usuarios').doc(doc).get();
}

getAllDocument( FirebaseFirestore db ) async {
  QuerySnapshot querySnapshot = await db.collection('usuarios').get();

  List<QueryDocumentSnapshot> docs = [];
  for (QueryDocumentSnapshot doc in querySnapshot.docs ) {
    docs.add(doc);
  }

  return docs;
}

getUpdatedUsers( FirebaseFirestore db) {
  List<DocumentSnapshot> docs = [];

  db.collection('usuarios')
    .snapshots()
    .listen((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs ) {
        docs.add(doc);
      }
    });
  
  return docs;
}

whereExample( FirebaseFirestore db) async {
   QuerySnapshot querySnapshot = await db.collection('usuarios')
    .where('nome', whereIn: ['Rosa', 'Ravi'])
    // .orderBy('idade', descending: true)
    .get();
  for (DocumentSnapshot element in querySnapshot.docs) {
    print(element.data().toString());
  }
}

createAuthUser(FirebaseAuth auth, {required String email, required String pass}) {
    auth.createUserWithEmailAndPassword(
    email: email,
    password: pass
  ).then((firebaseUser) {
    print( "novo usuário adicioando! E-mail: ${firebaseUser.user?.email}" );
  }).catchError((error){
    print('Falha ao criar usuário: ${error.toString()}');
  });
}

doLogin(FirebaseAuth auth, {required String email, required String pass}) {
// await auth.signOut();
  auth.signInWithEmailAndPassword(
    email: email,
    password: pass
  ).then((firebaseUser) {
    print( "usuário logado! E-mail: ${firebaseUser.user?.email}" );
  }).catchError((error){
    print('Falha ao logar usuário: ${error.toString()}');
  });

  User? user = auth.currentUser;
  if ( null != user ) {
    print('Usuário logado!' + user.email!);
  } else {
    print('Nenhum usuário logado');
  }
}

void main() async {
  // inicializa Firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _selectedImage;
  String _statusUplaod = '';
  String _imageUplaoded = '';

  Future _getImage( bool fromCam) async {
    ImageSource source = ImageSource.camera;
   
    if ( ! fromCam ) {
      source = ImageSource.gallery;
    }

    await ImagePicker.platform.getImageFromSource(
      source: source
    ).then((xfile) {
      setState(() {
        _selectedImage = File( xfile!.path );
      });
    });
  }

  Future<void> _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference main = storage.ref();
    Reference file = main.child('photos').child('foto1.jpg');

    if ( _selectedImage != null ) {
      UploadTask task = file.putFile(_selectedImage!);

      task.snapshotEvents.listen((event) {
        if ( event.state == TaskState.running ) {
          setState(() {
            _statusUplaod = 'Em progresso';
          });
        } else if ( event.state == TaskState.success ) {
          setState(() {
            _statusUplaod = 'Upload concluído';
          });
        }
      });

      task.then((snapshot) {
        _getUploadURL( snapshot );
      });
    }
  }

  _getUploadURL( TaskSnapshot snapshot ) async {
    String imageUrl = await snapshot.ref.getDownloadURL();
     setState(() {
        _imageUplaoded = imageUrl;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar imagem'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: Text(_statusUplaod),
              ),
              ElevatedButton(
                onPressed: () {
                  _getImage(true);
                },
                child: const Text('Camera')
              ),
              ElevatedButton(
                onPressed: () {
                  _getImage(false);
                },
                child: const Text('Galeria')
              ),
              _selectedImage == null
                ? Container()
                : Image.file(
                  _selectedImage!,
                  height: 300,
                ),
              ElevatedButton(
                onPressed: (){
                  _uploadImage();
                },
                child: const Text('Upload para o Storage')
              ),
              _imageUplaoded == ''
                ? Container()
                : Image.network(_imageUplaoded)
            ],
          ),
        ),
      ),
    );
  }
}