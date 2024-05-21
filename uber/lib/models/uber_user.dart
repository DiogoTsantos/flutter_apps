class UberUser {
  String? _idUser;
  String? _name;
  String? _email;
  String? _password;
  String? _type;
  double? _lat;
  double? _long;

  UberUser(
    {
      String? idUser,
      String? name,
      String? email,
      String? password,
      String? type,
      double? lat,
      double? long
    }
  ) : _idUser = idUser,
      _name = name,
      _email = email,
      _password = password,
      _type = type,
      _lat = lat,
      _long = long;

  String? get id => _idUser;
  set id( String? value) => _idUser = value;

  String? get name => _name;
  set name( String? value) => _name = value;

  String? get email => _email;
  set email( String? value) => _email = value;

  String? get password => _password;
  set password( String? value) => _password = value;

  String? get type => _type;
  set type( String? value) => _type = value;

  double? get lat => _lat;
  set lat( double? value) => _lat = value;

  double? get long => _long;
  set long( double? value) => _long = value;

  Map<String, dynamic> toMap () {
    Map<String, dynamic> map = {
      'name': _name,
      'email': _email,
      'type': _type,
      'id': _idUser,
      'lat': _lat,
      'long': _long
    };

    return map;
  }
}