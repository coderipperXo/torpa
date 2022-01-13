import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final LatLng center = const LatLng(9.0438, 38.7612);
  Map<MarkerId, Marker> markers = new Map<MarkerId, Marker>();
  

// firebase things

  DatabaseReference databaseReference;
  Future<FirebaseApp> future = Firebase.initializeApp();

  void add(String id, double latitude, double longitude) {
    var markeridval = id;
    MarkerId markerid = MarkerId(markeridval);
    Marker marker = Marker(
      markerId: markerid,
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: markeridval),
    );
    setState(() {
      markers[markerid] = marker;
      
    });
  }



  @override
  void initState() {
    // TODO: implement initState

    databaseReference = FirebaseDatabase.instance.reference();

    databaseReference.once().then((DataSnapshot data) {
      Map<dynamic, dynamic> snap = data.value;
      snap.forEach((key, values) {
        print(values["name"]);
        add(values["name"], values["latitude"],values["longitude"]); // omitting "[keys]" from the OPs approach
      });
    
    });

    //addmarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng _initialcameraposition = LatLng(8.9806, 38.7578);
    GoogleMapController controller;
    Location location = Location();
    String retrievedName = "";

    void _map(GoogleMapController _ctrl) {
      controller = _ctrl;
      location.onLocationChanged.listen((event) {
        double la = event.latitude;
        double lo = event.longitude;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(la, lo),
            zoom: 19.151926040649414,
            tilt: 59.440717697143555,
            bearing: 192.8334901395799)));
      });
    }

    return Scaffold(
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.hybrid,
              onMapCreated: _map,
              markers: Set<Marker>.of(markers.values),
            ),
          ],
        ),
      ),
    );
  }
}
