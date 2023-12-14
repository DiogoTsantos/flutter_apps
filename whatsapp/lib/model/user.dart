class UserApp {
  String? _id;
  String? _name;
  String? _mail;
  String? _pass;
  String? _urlImage;

  UserApp({
    String? id,
    String? name,
    String? mail,
    String? pass,
    String? urlImage,
  })
    : _id = id,
      _name = name,
      _mail = mail,
      _urlImage = urlImage,
      _pass = pass;
  
  String get id => _id ?? '';

  set id(String? value) {
    _id = value;
  }

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  String get mail => _mail ?? '';

  set mail(String value) {
    _mail = value;
  }

  String get pass => _pass ?? '';

  set pass(String value) {
    _pass = value;
  }

  String get urlImage => _urlImage ?? '';

  set urlImage(String value) {
    _urlImage = value;
  }

  Map<String,dynamic> toMap() {
    return {
      'name':name,
      'mail':mail,
      'pass': pass,
      'urlImage': urlImage
    };
  }
}