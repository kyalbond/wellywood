import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

  Widget googleMap(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(-41.2906446, 174.7761539), zoom: 12),
        onMapCreated: (GoogleMapController controller){
          Completer().complete(controller);
        },
        markers:{
          wellyMarker
        },
      )
    );
  }

Marker wellyMarker = Marker(
  markerId: MarkerId('wellyMarker'),
  position: LatLng(-41.2906446, 174.7761539),
  infoWindow: InfoWindow (title: 'Test'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  )
);
