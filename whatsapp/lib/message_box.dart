import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/model/message.dart';
import 'package:whatsapp/model/talk.dart';
import 'package:whatsapp/model/user.dart';

class MessageBox extends StatefulWidget {
  UserApp? contact;
  MessageBox(this.contact, {super.key});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final TextEditingController _controllerMessage = TextEditingController();
  String _idUserLogged = '';
  String _idUserFriend = '';
  bool _uploadingImage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recoverUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMessage,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 20
                ),
                decoration: InputDecoration(
                  hintText: 'Digite uma mensagem',
                  errorStyle: const TextStyle(
                    color: Colors.orangeAccent
                  ),
                  prefixIcon: 
                  _uploadingImage
                    ? const CircularProgressIndicator()
                    : IconButton(
                      onPressed: (){
                        _sendPhoto();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: Theme.of(context).primaryColor,
                      )
                    )
                ),
              ),
            ),
          ),
          Platform.isIOS
            ? CupertinoButton(
              child: const Text(
                'Enviar'
              ),
              onPressed: () {
                _sendMessage();
              },
            )
            : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              mini: true,
              onPressed: () {
                _sendMessage();
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
        ],
      ),
    );
  }

  _sendMessage() {
    String text = _controllerMessage.text;

    if ( _idUserLogged != null
      && text != ''
      && _idUserLogged != '' ) {
      Message message = Message(
        idUser: _idUserLogged,
        content: text,
        type: 'text',
        date: Timestamp.now().toString()
      );

      _saveMessage(
        _idUserLogged,
        _idUserFriend,
        message
      );

      _saveMessage(
        _idUserFriend,
        _idUserLogged,
        message
      );

      _saveTalk(message);

      _controllerMessage.clear();
    }
  }

  _sendPhoto() async {
    XFile? selecteImage = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.gallery
    );

    String imageName = DateTime.now().microsecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;

    _uploadingImage = true;
    Reference rootFolder = storage.ref();
    Reference file = rootFolder
      .child('messages')
      .child(_idUserLogged)
      .child('${imageName}.jpg');
    UploadTask task = file.putFile( File(selecteImage!.path) );

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

  _recoverUserData() {
    FirebaseAuth auth = FirebaseAuth.instance;

    _idUserLogged = auth.currentUser!.uid;
    _idUserFriend = widget.contact!.id;
  }

  _saveMessage( String idUserLogged, String idUserFriend, Message msg) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection('messages')
      .doc(idUserLogged)
      .collection(idUserFriend).
      add(msg.toMap());
  }

  _saveTalk( Message message ) {
    Talk talkRecipient = Talk();
    talkRecipient.idRecipient = widget.contact!.id;
    talkRecipient.idSender = _idUserLogged;
    talkRecipient.name = widget.contact!.name;
    talkRecipient.imagePath = widget.contact!.urlImage;
    talkRecipient.messageType = message.type;
    talkRecipient.message = message.type == 'text'
      ? message.content
      : message.urlImage;
    talkRecipient.save();
    
    Talk talkSender = Talk();
    talkSender.idRecipient = _idUserLogged;
    talkSender.idSender = widget.contact!.id;
    talkSender.name = widget.contact!.name;
    talkSender.imagePath = widget.contact!.urlImage;
    talkSender.messageType = message.type;
    talkSender.message = message.type == 'text'
      ? message.content
      : message.urlImage;
    talkSender.save();
  }

  Future _recoveryUrlPerfil(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    Message message = Message(
      idUser: _idUserLogged,
      urlImage: url,
      type: 'image',
      date: Timestamp.now().toString()
    );

    _saveMessage(
      _idUserLogged,
      _idUserFriend,
      message
    );

    _saveMessage(
      _idUserFriend,
      _idUserLogged,
      message
    );
  }
}