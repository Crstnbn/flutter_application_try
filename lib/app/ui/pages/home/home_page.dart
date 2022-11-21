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
        body: Consumer<HomeController>(
          builder: (_, controller, __) => GoogleMap(
            markers: controller.markers,
            initialCameraPosition: controller.initialCameraPosition,
            myLocationButtonEnabled: false,
            onTap: controller.onTap,
          ),
        ),
      ),
    );
  }
}
