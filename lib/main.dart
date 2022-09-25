import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart' as geoCo;

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

      //    routes: {
      //    'perfil': (BuildContext context) => ProfilePage(),
      // 'read': (BuildContext context) => ReadPage(),
      //},

      //initialRoute: Routes.SPLASH,
      //routes: appRoutes(),
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
  late Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Position position;
  late String addressLocation;
  late String postalCode;

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: addressLocation));
    setState(() {
      markers[markerId] = _marker;
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
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 600.0,
              child: GoogleMap(
                  onTap: (tapped) async {
                    // ignore: unnecessary_new
                    final coordinated = new geoCo.Coordinates(
                        tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local
                        .findAddressesFromCoordinates(coordinated);
                    var firstAddress = address.first;

                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance
                        .collection('location')
                        .add({
                      'latitude': tapped.latitude,
                      'longitude': tapped.longitude,
                      'Adress': firstAddress.addressLine,
                      'PostalCode': firstAddress.postalCode,
                    });
                    setState(() {
                      postalCode = firstAddress.postalCode;
                      addressLocation = firstAddress.addressLine;
                    });
                  },
                  myLocationButtonEnabled: true,
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
            Text('Address : $addressLocation'),
            Text('Postal Code: $postalCode'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
