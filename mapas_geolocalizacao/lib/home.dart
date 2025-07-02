import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition _cameraPosition =  const CameraPosition(
    target: LatLng(-10.907470808398154, -37.031571848866264),
    zoom: 16
  );
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  final Set<Polyline> _polylines = {};

  _moveCamera() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        _cameraPosition
      )
    );
  }
  _recoveryCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16
      );
    });
    _moveCamera();
  }

  _listenCurrentLocation() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,

      ),
    ).listen((Position position) {
      Marker user = Marker(
        markerId: const MarkerId('Minha localização'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Usuário'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen
        )
      );
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16,
        );
        _markers.add(user);
        _moveCamera();
      });
    });
  }

  _recoveryLocaltoAddress() async {
    _recuperarLocalParaEndereco() async {
 
    List<Location> listaEnderecos = await locationFromAddress("Av. Paulista, 1372");
  
    print("Total: " + listaEnderecos.length.toString());
  
    if( listaEnderecos != null && listaEnderecos.length > 0 ){
  
      Location endereco = listaEnderecos[0];
  
      List<Placemark> placemarks = await placemarkFromCoordinates(endereco.latitude, endereco.longitude);
  
      Placemark localizacao = placemarks[0];
  
      String resultado;
  
      resultado = "\n administrativeArea " + localizacao.administrativeArea;
      resultado += "\n subAdministrativeArea " + localizacao.subAdministrativeArea;
      resultado += "\n locality " + localizacao.locality;
      resultado += "\n sublocality " + localizacao.subLocality;
      resultado += "\n thoroughfare " + localizacao.thoroughfare;
      resultado += "\n subThoroughfare " + localizacao.subThoroughfare;
      resultado += "\n postalCode " + localizacao.postalCode;
      resultado += "\n country " + localizacao.country;
      resultado += "\n isoCountryCode " + localizacao.isoCountryCode;
      resultado += "\n name " + localizacao.name;
      resultado += "\n Latlng " + endereco.latitude.toString() + " " + endereco.longitude.toString();
  
      print("resultado 1: " + resultado );
  
    }
  }

  @override
  void initState() {
    super.initState();
    // _loadMarkers();
    // _recoveryCurrentLocation();]
    // _listenCurrentLocation();
    _recoveryLocaltoAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas & Geolocalização'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: _markers,
        // polygons: _polygons,
        // polylines: _polylines,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveCamera,
        child: const Icon(
          Icons.done
        ),
      ),
    );
  }
  
  void _loadMarkers() {
    /*
    Marker pierBarra = Marker(
      markerId: const MarkerId('Pier Barra'),
      position: const LatLng(-10.915008280463832, -37.03715130769968),
      infoWindow: const InfoWindow(title: 'Pier Barra'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue
      )
    );

    Marker bar = Marker(
      markerId: const MarkerId('Bar'),
      position: const LatLng(-10.904262649257088, -37.04079911205209),
      infoWindow: const InfoWindow(title: 'Bar do rio'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen
      )
    );

    setState(() {
      _markers.add(pierBarra);
      _markers.add(bar);
    });
    */

    /*  
    Polygon polygon = Polygon(
      polygonId: const PolygonId('Polygon 1'),
      fillColor: Colors.green,
      strokeColor: Colors.red,
      strokeWidth: 10,
      points: [
        LatLng(-10.907607763486462, -37.030112727217144),
        LatLng(-10.907470808398154, -37.031571848866264),
        LatLng(-10.905985368387782, -37.03121779728964),
      ]
    );

    setState(() {
      _polygons.add(polygon);
    });
    */

    Polyline polyline = const Polyline(
      polylineId: PolylineId('Polygon 1'),
      color: Colors.green,
      width: 25,
      jointType: JointType.bevel,
      points: [
        LatLng(-10.907607763486462, -37.030112727217144),
        LatLng(-10.907470808398154, -37.031571848866264),
        LatLng(-10.905985368387782, -37.03121779728964),
      ]
    );

    setState(() {
      _polylines.add(polyline);
    });
  }
}