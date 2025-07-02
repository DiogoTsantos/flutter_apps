import 'package:cloud_firestore/cloud_firestore.dart';

class Advert {
  String? _price;
  String? _state;
  String? _category;
  String? _title;
  String? _id;
  String? _description;
  String? _phone;
  List<String>? _photos;

  Advert({
    String? price,
    String? state,
    String? category,
    String? title,
    String? id,
    String? description,
    String? phone,
    List<String>? photos
  }) {
    _price = price;
    _state = state;
    _category = category;
    _title = title;
    _id = id;
    _description = description;
    _phone = phone;
    _photos = photos;

    _photos ??= [];
  }

  Advert.generateId() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference adverts = db.collection('my_adverts');
    _id = adverts.doc().id;

    _photos = [];
  }

  Advert.fromDocumentSnapshot( DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.id;
    _price = documentSnapshot['price'];
    _state = documentSnapshot['state'];
    _category = documentSnapshot['category'];
    _title = documentSnapshot['title'];
    _description = documentSnapshot['description'];
    _phone = documentSnapshot['phone'];
    _photos = List<String>.from(documentSnapshot['photos']);
  }

  Map<String, dynamic> toMap() {
    return {
      'price': _price,
      'state': _state,
      'category': _category,
      'title': _title,
      'id': _id,
      'description': _description,
      'phone': _phone,
      'photos': _photos
    };
  }

  get price => _price;
  get state => _state;
  get category => _category;
  get title => _title;
  get id => _id;
  get description => _description;
  get phone => _phone;
  List<String>? get photos => _photos;

  set price(value) => _price = value;
  set state(value) => _state = value;
  set category(value) => _category = value;
  set title(value) => _title = value;
  set id(value) => _id = value;
  set description(value) => _description = value;
  set phone(value) => _phone = value;
  set photos(value) => _photos = value;
}