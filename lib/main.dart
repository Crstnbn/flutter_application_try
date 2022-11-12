import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:flutter_application_try/app/ui/routes/pages.dart';
//import 'package:flutter_application_try/app/ui/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geocoding',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController googleMapController;
  late Position position;

  //final List<Marker> _manyMarker = [];

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'Perrito encontrado',
        ));
    setState(() {
      markers[markerId] = _marker;
    });
  }

/*
await FirebaseFirestore.instance.collection('location').add({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Jehan'
      },

title: 'Perrito encontrado',
                    snippet:
                        'Latitud ${position.latitude}, longitud ${position.longitude}'
*/
  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: GoogleMap(
            onTap: (tapped) async {
              getMarkers(tapped.latitude, tapped.longitude);
              await FirebaseFirestore.instance.collection('location').add({
                'latitude': tapped.latitude,
                'longitude': tapped.longitude,
              });
            },
            mapType: MapType.normal,
            compassEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                googleMapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude.toDouble(),
                    position.longitude.toDouble()),
                zoom: 15.0),
            markers: Set<Marker>.of(markers.values)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
