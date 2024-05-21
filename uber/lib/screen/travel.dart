import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uber/models/uber_user.dart';
import 'package:uber/utils/camera.dart';
import 'package:uber/utils/firebase_user.dart';
import 'package:uber/utils/markers.dart';
import 'package:uber/utils/travel_status.dart';
import 'package:uber/utils/user_location.dart';

class Travel extends StatefulWidget {
  const Travel(this.idTravel, {super.key});
  final String idTravel;

  @override
  State<Travel> createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  final Camera _camera = Camera();
  final Markers _markers = Markers();
  late final UserLocation _driver;
  String _travelID = '';
  
  String _travelStatus = TravelStatus.AGUARDANDO;

  String _statusMessage = 'Painel da corrida';

  // Page controllers.
  String _buttonText = 'Aceitar corrida';
  Color _buttonColor = const Color(0xff1ebbd8);
  Function? _actionButton;

  Map<String, dynamic> _dataTravel = {};

  _addListennerActiveTravel() async {
    UberUser firebaseUser = await FirebaseUser.getLoggedUserData();
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('travels_active')
      .doc(firebaseUser.id)
      .snapshots()
      .listen((snapshot) {
      if ( snapshot.data() != null ) {
        Map<String, dynamic>? data = snapshot.data();
        // _travelID = data!['id_travel'];
        _handleActionButton(data!['status']);
      } else {
        _handleActionButton('START');
      }
    });
  }

  _handleActionButton( String action ) {
    switch (action) {
      case TravelStatus.AGUARDANDO:
        _changeActionButton(
          'Aceitar Corrida',
          const Color(0xff1ebbd8),
          () { _aceptTravel(); }
        );

        Position position = Position(
          longitude: _driver.local!.longitude,
          latitude: _driver.local!.latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0
        );

        _markers.showMarker(
          position,
          'images/motorista.png',
          'Motorista',
          context
        );

        _camera.moveCamera(
          CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: 19
          )
        );
        break;
      case TravelStatus.A_CAMINHO:
        _statusMessage = 'A caminho do passageiro';
        _changeActionButton(
          'Iniciar corrida',
          const Color(0xff1ebbd8),
          () {
            _initTravel();
          }
        );

        _markers.displayTwoMarkers(
          LatLng(_dataTravel['driver']['lat'], _dataTravel['driver']['long']),
          LatLng(_dataTravel['passenger']['lat'], _dataTravel['passenger']['long']),
          context,
          _camera
        );
        break;
      case TravelStatus.VIAGEM:
        _statusMessage = 'Em viagem';
        _changeActionButton(
          'Finalizar corrida',
          const Color(0xff1ebbd8),
          () {
            _finalizeTravel();
          }
        );

        _markers.displayTwoMarkers(
          LatLng(_dataTravel['driver']['lat'], _dataTravel['driver']['long']),
          LatLng(_dataTravel['destination']['lat'], _dataTravel['destination']['long']),
          context,
          _camera
        );
        break;
      case TravelStatus.FINALIZADA:
        double distanceMeters = Geolocator.distanceBetween(
          _dataTravel['origin']['lat'],
          _dataTravel['origin']['long'],
          _dataTravel['destination']['lat'],
          _dataTravel['destination']['long']
        );

        distanceMeters /= 1000; // meters to kilometers.

        double travelCost = distanceMeters * 8;

        NumberFormat format = NumberFormat('#,##0.00', 'pt_BR');
        String costFormatted = format.format(travelCost);
        _statusMessage = 'Viagem finalizada';
        _changeActionButton(
          'Confirmar - R\$ $costFormatted',
          const Color(0xff1ebbd8),
          () {
            _confirmTravel();
          }
        );

        Position position = Position(
          longitude: _dataTravel['destination']['long'],
          latitude: _dataTravel['destination']['lat'],
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0
        );

        setState(() {
          _markers.showMarker(
            position,
            'images/destino.png',
            'Destino',
            context
          );
        });

        _camera.moveCamera(
          CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: 19
          )
        );
        break;
      case TravelStatus.CONFIRMADA:
        Navigator.pushReplacementNamed(
          context,
          '/driver'
        );
        break;
      default:
      _changeActionButton(
        'Rejeitar corrida',
        Colors.red,
        () { /*_callUber();*/ }
      );
    }
  }

  _confirmTravel() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('travels')
      .doc(_travelID)
      .update({
        'status': TravelStatus.CONFIRMADA
      });

    db.collection('travels_active')
    .doc(_dataTravel['passenger']['id'])
    .delete();

    db.collection('travels_active_driver')
    .doc(_dataTravel['driver']['id'])
    .delete();
  }

  _finalizeTravel() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('travels')
      .doc(_travelID)
      .update(
        {
          'status': TravelStatus.FINALIZADA
        }
      );

    db.collection('travels_active')
    .doc(_dataTravel['passenger']['id'])
    .update({
      'status': TravelStatus.FINALIZADA
    });

    db.collection('travels_active_driver')
    .doc(_dataTravel['driver']['id'])
    .update({
      'status': TravelStatus.FINALIZADA
    });
  }

  _initTravel() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('travels')
      .doc(_travelID)
      .update({
        'origin': {
          'lat': _dataTravel['driver']['lat'],
          'long': _dataTravel['driver']['long']
        },
        'status': TravelStatus.VIAGEM
      });

    db.collection('travels_active')
    .doc(_dataTravel['passenger']['id'])
    .update({
      'status': TravelStatus.VIAGEM
    });

    db.collection('travels_active_driver')
    .doc(_dataTravel['driver']['id'])
    .update({
      'status': TravelStatus.VIAGEM
    });
  }

  _aceptTravel () async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    UberUser user = await FirebaseUser.getLoggedUserData();
    user.lat = _driver.local!.latitude;
    user.long = _driver.local!.longitude;
    db.collection('travels').doc(_dataTravel['id']).update({
      'driver': user.toMap(),
      'status': TravelStatus.A_CAMINHO
    }).then((_) {
      _addListennerTravel();
      db.collection('travels_active')
        .doc(_dataTravel['passenger']['id'])
        .update({
          'status': TravelStatus.A_CAMINHO
        });

      db.collection('travels_active_driver')
        .doc(user.id)
        .set({
          'id': _dataTravel['id'],
          'idUser': user.id,
          'status': TravelStatus.A_CAMINHO
      });
    });
  }

  _changeActionButton( String buttonText, Color buttonColor, Function actionButton ) {
    setState(() {
      _buttonText = buttonText;
      _buttonColor = buttonColor;
      _actionButton = actionButton;
    });
  }

  _recoveryTravel() async {
    String idTravel = widget.idTravel;
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db.collection('travels')
      .doc(idTravel)
      .get();

    _dataTravel = snapshot.data() as Map<String, dynamic>;
    _addListennerTravel();
  }

  _addListennerTravel() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('travels').doc(_travelID).snapshots().listen((snapshot) {
      if ( snapshot.data() != null ) {
        Map<String, dynamic>? data = snapshot.data();
        _travelStatus = data!['status'];
        _dataTravel = data;

        _handleActionButton(data!['status']);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _driver = UserLocation(
      _camera,
      _markers
    );
    _travelID = widget.idTravel;
    _recoveryTravel();
    _driver.recoveryLastPosition(
      'images/motorista.png',
      'Motorista',
      context
    );
    _driver.currentLocationListenner(
      _travelID,
      _travelStatus,
      context,
      'images/motorista.png',
      'Motorista',
      null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_statusMessage),
      ),
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _camera.cameraPosition,
              onMapCreated: _camera.onMapCreated,
              // myLocationEnabled: true,
              markers: _markers.markers,
              myLocationButtonEnabled: false,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                   style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(_buttonColor ),
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(32, 16, 32, 16)),
                    ),
                    onPressed: () {
                      _actionButton!();
                    },
                    child: Text(
                      _buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
              )
            )
          ]
        ),
      ),
    );
  }
}