class Message {
  String _idUser;
  String? _content;
  String? _urlImage;
  String _type;
  String _date;

  Message({
    required idUser,
    content,
    urlImage,
    type,
    date
  }) : _idUser = idUser,
  _content = content,
  _urlImage = urlImage,
  _type = type,
  _date = date;

  Map<String,dynamic> toMap() {
    return {
      'idUser': _idUser,
      'content': _content,
      'urlImage': _urlImage,
      'type': _type,
      'date': _date,
    };
  }

  String get idUser => _idUser;

  String get content => _content ?? '';

  String get urlImage => _urlImage ?? '';

  String get type => _type;

  String get date => _date;

  set idUser(String value) {
    _idUser = value;
  }

  set content(String value) {
    _content = value;
  }

  set urlImage(String value) {
    _urlImage = value;
  }

  set type(String value) {
    _type = value;
  }

  set ate(String value) {
    _date = value;
  }
}