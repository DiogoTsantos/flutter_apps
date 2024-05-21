class Destination {
  String? _street;
  String? _number;
  String? _city;
  String? _neighborhood;
  String? _zipcode;
  double? _lat;
  double? _long;

  Destination(
    this._street,
    this._number,
    this._city,
    this._neighborhood,
    this._zipcode,
    this._lat,
    this._long
  );

  Map<String, dynamic> toMap () {
    Map<String, dynamic> map = {
      'street': _street,
      'number': _number,
      'city': _city,
      'neighborhood': _neighborhood,
      'zipcode': _zipcode,
      'lat': _lat,
      'long': _long
    };
    return map;
  }

  get street => _street;
  set street(value) => _street = value;

  get number => _number;
  set number(value) => _number = value;

  get city => _city;
  set city(value) => _city = value;

  get neighborhood => _neighborhood;
  set neighborhood(value) => _neighborhood = value;

  get zipcode => _zipcode;
  set zipcode(value) => _zipcode = value;

  get lat => _lat;
  set lat(value) => _lat = value;

  get long => _long;
  set long(value) => _long = value;
}