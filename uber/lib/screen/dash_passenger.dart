import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uber/models/destination.dart';
import 'package:uber/models/travel.dart';
import 'package:uber/models/uber_user.dart';
import 'package:uber/utils/camera.dart';
import 'package:uber/utils/firebase_user.dart';
import 'package:uber/utils/markers.dart';
import 'package:uber/utils/travel_status.dart';
import 'package:uber/utils/user_location.dart';

class DashPassenger extends StatefulWidget {
  const DashPassenger({super.key});

  @override
  State<DashPassenger> createState() => _DashPassengerState();
}

class _DashPassengerState extends State<DashPassenger> {
  final List<String> _menuItems = [
    'Configurações',
    'Sair'
  ];

  final Markers _markers = Markers();
  final Camera _camera = Camera();
  late final UserLocation _passenger;
  final TextEditingController _searchController = TextEditingController();
  String _travelID = '';

  // Page controllers.
  bool _showDestinationBox = true;
  String _buttonText = 'Chamar Uber';
  Color _buttonColor = const Color(0xff1ebbd8);
  Function? _actionButton;

  Map<String, dynamic> _dataTravel = {};

  StreamSubscription<DocumentSnapshot>? _subscription;

  _logoutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
      context,
      '/'
    );
  }
  _choosenMenuItem(String value) {
    if (value == 'Sair') {
      _logoutUser();
    }
  }

  _callUber() async {
    String destination = _searchController.text;
    if ( destination.isNotEmpty ) {
      List<Location>? locations = await locationFromAddress(destination);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        locations.first.latitude,
        locations.first.longitude
      );

      if ( placemarks != null && placemarks.isNotEmpty ) {
        Placemark placemark = placemarks.first;
        
        Destination destination = Destination(
          placemark.thoroughfare,
          placemark.subThoroughfare,
          placemark.subAdministrativeArea,
          placemark.subLocality,
          placemark.postalCode,
          locations.first.latitude,
          locations.first.longitude
        );

        String formatedDestination = "Cidade: ${destination.city}";
        formatedDestination += " \n Bairro: ${destination.neighborhood}";
        formatedDestination += " \n Rua: ${destination.street} ${destination.number}";
        formatedDestination += " \n CEP: ${destination.zipcode}";

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Endereço de destino"),
              content: Text(formatedDestination),
              contentPadding: const EdgeInsets.all(16),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  )
                ),
                TextButton(
                  onPressed: () {
                    _saveTravel(destination);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  )
                )
              ],
            );
          },
        );
      }
    }
  }

  _saveTravel( Destination destination ) async {
    UberUser passenger = await FirebaseUser.getLoggedUserData();
    passenger.lat = _passenger.local!.latitude;
    passenger.long = _passenger.local!.longitude;

    Travel travel = Travel(
      destination: destination,
      status: TravelStatus.AGUARDANDO,
      passenger: passenger
    );

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('travels').doc(travel.id).set(travel.toMap());

    db.collection('travels_active').doc(travel.passenger.id).set(
      {
        'id_travel': travel.id,
        'id_user': travel.passenger.id,
        'status': TravelStatus.AGUARDANDO
      }
    );

    if ( _subscription == null ) {
      _addListennerTravel(travel.id);
    }
  }

  _handleActionButton( String action ) {
    switch (action) {
      case TravelStatus.AGUARDANDO:
        _showDestinationBox = false;
        _changeActionButton(
          'Cancelar',
          Colors.red,
          () { _cancellUber(); }
        );

        Position position = Position(
          latitude: _dataTravel['passenger']['lat'],
          longitude: _dataTravel['passenger']['long'],
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
          
        );
        setState(() {
          _markers.showMarker(
            position,
            'images/passageiro.png',
            'Meu local',
            context
          );
        });
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 18
        );
        _camera.moveCamera(cameraPosition);
        break;
      case TravelStatus.A_CAMINHO:
        _showDestinationBox = false;
        _changeActionButton(
          'Motorista a caminho',
          Colors.grey,
          () {}
        );

        _markers.displayTwoMarkers(
          LatLng(_dataTravel['driver']['lat'], _dataTravel['driver']['long']),
          LatLng(_dataTravel['passenger']['lat'], _dataTravel['passenger']['long']),
          context,
          _camera
        );
        break;
      case TravelStatus.VIAGEM:
        _showDestinationBox = false;
        _changeActionButton(
          'Em viagem',
          Colors.grey,
          () {}
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
        _changeActionButton(
          'Total - R\$ $costFormatted',
          Colors.green,
          () {
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
        if ( _subscription != null ) {
          _subscription!.cancel();
          _subscription = null;
        }

        _showDestinationBox = true;
        _changeActionButton(
          'Chamar Uber',
          const Color(0xff1ebbd8),
          () { _callUber(); }
        );

         Position position = Position(
          latitude: _dataTravel['passenger']['lat'],
          longitude: _dataTravel['passenger']['long'],
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
          
        );
        setState(() {
          _markers.showMarker(
            position,
            'images/passageiro.png',
            'Meu local',
            context
          );
        });
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 18
        );
        _camera.moveCamera(cameraPosition);

        _dataTravel = {};
        break;
      default:
        _showDestinationBox = true;
        _changeActionButton(
          'Chamar Uber',
          const Color(0xff1ebbd8),
          () { _callUber(); }
        );

        if ( _passenger.local != null ) {
          Position position = Position(
            latitude: _passenger.local!.latitude,
            longitude: _passenger.local!.longitude,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            altitudeAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            speed: 0,
            speedAccuracy: 0,
            
          );
          _markers.showMarker(
            position,
            'images/passageiro.png',
            'Meu local',
            context
          );
          CameraPosition cameraPosition = CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: 18
          );
          _camera.moveCamera(cameraPosition);
        }
    }
  }

  _changeActionButton( String buttonText, Color buttonColor, Function actionButton ) {
    setState(() {
      _buttonText = buttonText;
      _buttonColor = buttonColor;
      _actionButton = actionButton;
    });
  }

  _cancellUber() async {
    UberUser firebaseUser = await FirebaseUser.getLoggedUserData();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('travels').doc(_travelID).update({
      'status': TravelStatus.CANCELADA
    }).then((value) {
      db.collection('travels_active').doc(firebaseUser.id).delete();
      if ( _subscription != null ) {
        _subscription!.cancel();
        _subscription = null;
      }
    });
  }

  _recoveryActiveTravel() async {
    UberUser firebaseUser = await FirebaseUser.getLoggedUserData();
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection('travels_active')
      .doc(firebaseUser.id)
      .get();
    
    if ( snapshot.data() != null ) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      _travelID = data!['id_travel'];
      _addListennerTravel(_travelID);
    } else {
      _handleActionButton('START');
    }
  }

  _addListennerTravel( String idTravel) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    _subscription = await db.collection('travels').doc(idTravel).snapshots().listen((snapshot) {
      if ( snapshot.data() != null ) {
        Map<String, dynamic>? data = snapshot.data();
        _travelID = data!['id'];
        _dataTravel = data;
        _handleActionButton(data!['status']);
      }   
    });
  }

  @override
  void initState() {
    super.initState();
     _passenger = UserLocation(
      _camera,
      _markers
    );

    _recoveryActiveTravel();
    _passenger.recoveryLastPosition(
      'images/passageiro.png',
      'Passageiro',
      context
    );
    _passenger.currentLocationListenner(
      _travelID,
      null,
      context,
      'images/passageiro.png',
      'Passageiro',
      _handleActionButton
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passageiro'),
        actions: [
          PopupMenuButton(
            onSelected: _choosenMenuItem,
            itemBuilder: (context) {
              return _menuItems.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item)
                );
              }).toList();
            }
          )
        ],
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
            Visibility(
              visible: _showDestinationBox,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white
                        ),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            icon: Container(
                              width: 10,
                              height: 25,
                              margin: const EdgeInsets.only(left: 20, top: 0),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                            ),
                            hintText: 'Meu local',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 5)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            icon: Container(
                              width: 10,
                              height: 25,
                              margin: const EdgeInsets.only(left: 20, top: 0),
                              child: const Icon(
                                Icons.local_taxi,
                                color: Colors.black,
                              ),
                            ),
                            hintText: 'Destino',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 5)
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              )
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription!.cancel();
    _subscription = null;
  }
}