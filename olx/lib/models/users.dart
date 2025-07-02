class Users {
  String? _idUser;
  String? _name;
  String? _email;
  String? _password;

  Users({idUser, name, email, password})
  : _idUser = idUser,
  _name = name,
  _email = email,
  _password = password;

  String? get idUser => _idUser;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;

  set idUser(String? idUser) => _idUser = idUser;
  set name(String? name) => _name = name;
  set email(String? email) => _email = email;
  set password(String? password) => _password = password;

  Map<String, dynamic> toMap() {
    return {
      'idUser': _idUser,
      'name': _name,
      'email': _email,
    };
  }
}