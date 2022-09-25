/* ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/navigation/bottom_nav.dart';
import 'package:flutter_application_try/app/ui/pages/home/home.controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart' as geoCo;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Position position;
  late String address;
  late String postalCode;

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(snippet: "Direccion"));

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
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),

      //maker
      //final controller = HomeController();
      //controller.onMarkerTap.listen((String id) {
      //final route = MaterialPageRoute(builder: (context) => ProfilePage());

      //  Navigator.push(context, route);
      //generar dialogo o ruta al hacer click en marcador
      //print("got to $id");
      //  });
      //    return controller;
      //    },
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: const Bnavigator(),
        body: Selector<HomeController, bool>(
          selector: (_, controller) => controller.loading,
          builder: (context, loading, loadingWidget) {
            if (loading) {
              return loadingWidget!;
            }

            return Consumer<HomeController>(
              builder: (_, controller, gpsMesaggeWidget) {
                if (!controller.gpsEnabled) {
                  return gpsMesaggeWidget!;
                }

                final initialCameraPosition = CameraPosition(
                  target: LatLng(
                    controller.initialPosition!.latitude,
                    controller.initialPosition!.longitude,
                  ),
                  zoom: 16,
                );

                return Stack(
                  children: [
                    GoogleMap(
                      onTap: (tapped) async {
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
                      },
                      onMapCreated: controller.onMapCreated,
                      initialCameraPosition: initialCameraPosition,
                      myLocationButtonEnabled: true,
                      compassEnabled: false,
                      myLocationEnabled: true,
                      markers: Set<Marker>.of(markers.values),
                    ),
                    Text('Address : $address'),
                    Text('Postalcode : $postalCode'),
                  ],
                );
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "La aplicacion requiere acceso a tu ubicacion",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          final controller = context.read<HomeController>();
                          controller.turnOnGPS();
                        },
                        child: const Text("Activa tu GPS")),
                  ],
                ),
              ),
            );
          },

          //POSIBLE ERROR
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
*/
