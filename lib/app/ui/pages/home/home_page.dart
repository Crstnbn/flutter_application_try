import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/home/home_controller.dart';
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
          print("got to $id");
          //dialogo o pantalla
        });

        return controller;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Selector<HomeController, bool>(
          selector: (_, controller) => controller.loading,
          builder: (context, loading, loadingWidget) {
            if (loading) {
              return loadingWidget!;
            }
            return Consumer<HomeController>(
              builder: (_, controller, gpsMessageWidget) {
                if (!controller.gpsEnable) {
                  return gpsMessageWidget!;
                }

                return GoogleMap(
                  markers: controller.markers,
                  initialCameraPosition: controller.initialCameraPosition,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onTap: controller.onTap,
                );
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Para utilizar la aplicacion \n debe tener activo el gps",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final controller = context.read<HomeController>();
                          controller.turnOnGPS();
                        },
                        child: const Text('Activar el gps'))
                  ],
                ),
              ),
            );
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
