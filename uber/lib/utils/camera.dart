import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Camera {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(
      -10.987569111409128,
      -37.048115071021535,
    )
  );

  onMapCreated( GoogleMapController controller ) {
    _controller.complete(controller);
  }

  moveCamera( CameraPosition cameraPosition ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition)
    );
  }

  moveCameraBounds( LatLngBounds latLngBounds ) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        latLngBounds,
        100
      )
    );
  }

  CameraPosition get cameraPosition => _cameraPosition;

  set cameraPosition( CameraPosition cameraPosition ) {
    _cameraPosition = cameraPosition;
  }
}