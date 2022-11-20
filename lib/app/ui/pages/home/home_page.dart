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
          print('got to $id');
          //navegar perfil
        });

        return controller;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Citty Doggy')),
        body: Selector<HomeController, bool>(
          selector: (_, controller) => controller.loading,
          builder: (context, loading, loadingWidget) {
            if (loading) {
              return loadingWidget!;
            }
            return Consumer<HomeController>(
              builder: (_, controller, gpsMessageWidget) {
                if (controller.gpsEnabled) {
                  return gpsMessageWidget!;
                }

                return GoogleMap(
                  markers: controller.markers,
                  onMapCreated: (controller) {},
                  initialCameraPosition: controller.initialCameraPosition,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onTap: controller.onTap,

                  /*onLongPress: (Position) {
                    print(Position);
          
          },*/
                );
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Para usar la aplicacio, debe hablitar el gps'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final controller = context.read<HomeController>();
                        controller.turnOnGPS();
                      },
                      child: const Text('Encender gps'),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
