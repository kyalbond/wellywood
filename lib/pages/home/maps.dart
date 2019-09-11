import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
  final GeoPoint location;

  Maps({this.location});

  Widget build(BuildContext context) {
    return new Scaffold(
                  appBar: AppBar(
        title: Text('Wellington'),
      ),
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude, location.longitude), zoom: 15),
      onMapCreated: (GoogleMapController controller) {
        Completer().complete(controller);
      },
      markers: {
        Marker(
            markerId: MarkerId('wellyMarker'),
            position: LatLng(location.latitude, location.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow,
            ))
      },
    ));
  }
}
