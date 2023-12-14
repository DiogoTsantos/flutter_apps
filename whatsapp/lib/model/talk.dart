import 'package:cloud_firestore/cloud_firestore.dart';

class Talk {
  String? idRecipient;
  String? idSender;
  String? name;
  String? message;
  String? imagePath;
  String? messageType;

  // String get idRecipient => _idRecipient;
  // String get idSender => _idSender;
  // String get name => _name;
  // String get message => _message;
  // String get imagePath => _imagePath;
  // String get messageType => _messageType;

  // set idRecipient(String value) {
  //   _idRecipient = value;
  // }
  // set idSender(String value) {
  //   _idSender = value;
  // }
  // set name(String value) {
  //   _name = value;
  // }
  // set message(String value) {
  //   _message = value;
  // }
  // set imagePath(String value) {
  //   _imagePath = value;
  // }
  // set messageType(String value) {
  //   _messageType = value;
  // }

  save() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('talks')
      .doc(idSender)
      .collection('last_talk')
      .doc(idRecipient)
      .set(toMap());
  }

   Map<String,dynamic> toMap() {
    return {
      'idRecipient': idRecipient,
      'idSender': idSender,
      'name':name,
      'message': message,
      'imagePath': imagePath,
      'messageType': messageType
    };
  } 
}