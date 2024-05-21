import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/utils/camera.dart';
import 'package:uber/utils/firebase_user.dart';
import 'package:uber/utils/markers.dart';
import 'package:uber/utils/travel_status.dart';

class UserLocation {
  Position? _local;
  final Camera _camera;
  final Markers _markers;

  UserLocation(
    this._camera,
    this._markers
  );

  _checkUserPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  recoveryLastPosition( String icon, String infoWindow, BuildContext context ) async {
    await _checkUserPermissions();
    Position? position = await Geolocator.getLastKnownPosition();
    if ( position != null ) {
      _markers.showMarker(
        position,
        icon,
        infoWindow,
        context
      );

      _camera.cameraPosition = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 19
      );

      _camera.moveCamera( _camera.cameraPosition );
      _local = position;
    }
  }

  currentLocationListenner( String? travelID, String? travelStatus, BuildContext context, String icon, String infoWindow, Function? action ) {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      if ( travelID != null
        && travelID.isNotEmpty
        && travelStatus != TravelStatus.AGUARDANDO ) {
        FirebaseUser.updateDataLocation(
          travelID,
          position.latitude,
          position.longitude
        );
      } else if ( position != null ) {
        _local = position;

        if ( action != null ) {
          action( 'START' );
        }

        _markers.showMarker(
          position,
          icon,
          infoWindow,
          context
        );
        _camera.cameraPosition = CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 18
        );

        _camera.moveCamera( _camera.cameraPosition );
      }
    });
  }

  Position? get local => _local;
  set local( Position? value ) => _local = value;
}