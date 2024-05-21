import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/utils/camera.dart';

class Markers {
  Set<Marker> _markers = {};

  showMarker(Position local, String icon, String infoWindow, BuildContext context) {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
      icon
    ).then((BitmapDescriptor iconBitmap) {
       Marker marker = Marker(
        markerId: MarkerId(
          icon
        ),
        position: LatLng(
          local.latitude,
          local.longitude
        ),
        infoWindow: InfoWindow(
          title: infoWindow
        ),
        icon: iconBitmap  
      );

      _markers.add(marker);
    });
  }

  displayTwoMarkers( LatLng start, LatLng end, BuildContext context, Camera camera ) {
    Set<Marker> markers = {};

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
      'images/motorista.png'
    ).then((BitmapDescriptor icon) {
       Marker driver = Marker(
        markerId: const MarkerId(
          'motorista'
        ),
        position: LatLng(
          start.latitude,
          start.longitude
        ),
        infoWindow: const InfoWindow(
          title: 'Meu local'
        ),
        icon: icon  
      );

      markers.add(driver);
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
      'images/passageiro.png'
    ).then((BitmapDescriptor icon) {
       Marker driver = Marker(
        markerId: const MarkerId(
          'passageiro'
        ),
        position: LatLng(
          end.latitude,
          end.longitude
        ),
        infoWindow: const InfoWindow(
          title: 'Local do passageiro'
        ),
        icon: icon  
      );

      markers.add(driver);
    });

    _markers = markers;

    var southLat, southLong, northLat, northLong;

    if ( start.latitude <= end.latitude ) {
      southLat = start.latitude;
      northLat = end.latitude;        
    } else {
      southLat = end.latitude;
      northLat = start.latitude;        
    }

    if ( start.longitude <= end.longitude ) {
      southLong = start.longitude;
      northLong = end.longitude;        
    } else {
      southLong = end.longitude;
      northLong = start.longitude;        
    }

    camera.moveCameraBounds(
      LatLngBounds(
        southwest: LatLng(southLat, southLong),
        northeast: LatLng(northLat, northLong)
      )
    );
  }

  Set<Marker> get markers => _markers;

  set marker( Set<Marker> marker ) {
    _markers = marker;
  }
}