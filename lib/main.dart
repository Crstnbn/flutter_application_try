import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:flutter_application_try/app/ui/routes/pages.dart';
//import 'package:flutter_application_try/app/ui/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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
  late Position position;

  final List<Marker> _manyMarker = [];

  Marker _marker = const Marker(
      markerId: MarkerId('m1'),
      position: LatLng(-33.360458, -70.710031),
      infoWindow: InfoWindow(title: 'Perrito encontrado', snippet: 'll'),
      draggable: true);

  //Map<MarkerId,Marker> markers = <MarkerId, Marker>{};

  /* void getMarkers(double lat, double long) {
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
        body: GoogleMap(
          onTap: (position) {
            setState(() {
              _manyMarker.add(Marker(
                markerId: MarkerId('Marker ${_manyMarker.length}'),
                position: LatLng(position.latitude, position.longitude),
                infoWindow: InfoWindow(
                    title: 'Perrito encontrado',
                    snippet:
                        'Latitud ${position.latitude}, longitud ${position.longitude}'),
                draggable: true,
              ));
            });
          },
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              googleMapController = controller;
            });
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  position.latitude.toDouble(), position.longitude.toDouble()),
              zoom: 15.0),
          markers: Set<Marker>.from(_manyMarker),
        ));
  }
}
