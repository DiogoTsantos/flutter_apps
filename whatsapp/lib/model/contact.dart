class Contact {
  String _name;
  String _imagePath;

  Contact({
    required String name,
    required String imagePath,
  }) :
  _name = name,
  _imagePath = imagePath;

  String get name => _name;
  String get imagePath => _imagePath;

  set name(String value) {
    _name = value;
  }
  set imagePath(String value) {
    _imagePath = value;
  }
}