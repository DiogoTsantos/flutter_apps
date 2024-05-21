import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/models/destination.dart';
import 'package:uber/models/uber_user.dart';

class Travel {
  String? _id;
  String? _status;
  UberUser? _passenger;
  UberUser? _driver;
  Destination? _destination;

  Travel(
    {
      String? status,
      UberUser? passenger,
      UberUser? driver,
      Destination? destination
    }
  ) : _id = getRequestID(),
      _status = status,
      _passenger = passenger,
      _driver = driver,
      _destination = destination;

  get id => _id;
  set id(value) => _id = value;

  get status => _status;
  set status(value) => _status = value;

  get passenger => _passenger;
  set passenger(value) => _passenger = value;

  get driver => _driver;
  set driver(value) => _driver = value;

  get destination => _destination;
  set destination(value) => _destination = value;

  static String getRequestID() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db.collection('travels').doc().id;
  }

  Map<String, dynamic> toMap () {
    Map<String, dynamic> map = {
      'id': _id,
      'status': _status,
      'passenger': _passenger?.toMap(),
      'driver': _driver?.toMap(),
      'destination': _destination?.toMap()
    };

    return map;
  }
}