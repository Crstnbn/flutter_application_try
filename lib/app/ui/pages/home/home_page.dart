import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/navigation/bottom_nav.dart';
import 'package:flutter_application_try/app/ui/pages/home/home.controller.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/perfil_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) {
        final controller = HomeController();
        controller.onMarkerTap.listen((String id) {
          final route = MaterialPageRoute(builder: (context) => ProfilePage());

          Navigator.push(context, route);
          //generar dialogo o ruta al hacer click en marcador
          //print("got to $id");
        });
        return controller;
      },
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

                return GoogleMap(
                  markers: controller.markers,
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: initialCameraPosition,
                  myLocationButtonEnabled: true,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  onTap: controller.onTap,
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
}
