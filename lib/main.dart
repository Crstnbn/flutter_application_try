import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geocoding',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late GoogleMapController googleMapController;
  late Position position;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(snippet: 'address'));
    setState(() {
      markers[markerId] = marker;
    });
  }

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
      body: Column(
        children: [
          SizedBox(
            height: 900.0,
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
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  googleMapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude.toDouble(),
                    position.longitude.toDouble()),
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(markers.values),
            ),
          )
        ],
      ),
    );
  }
}
