// location_page.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyanAccent,
        // onPrimary: Colors.cyan,
        fontFamily: 'Roboto',
      ),
      home: Location(),
    );
  }
}

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VEHICLE LOCATION',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.cyanAccent,
        toolbarHeight: 75.0,
        elevation: 5.0,
      ),
      body: Center(
        child: MapWidget(),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(31.255392204464133, 75.70512765216785),
        zoom: 9.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId('predefined_location'),
          position: LatLng(31.255392204464133, 75.70512765216785),
          infoWindow: InfoWindow(title: 'Predefined Location'),
        ),
      },
      onMapCreated: (GoogleMapController controller) {},
      mapType: MapType.normal,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      buildingsEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
    );
  }
}
