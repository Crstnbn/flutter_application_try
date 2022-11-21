import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_application_try/app/helpers/asset_to_bytes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();
  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  final initialCameraPosition =
      const CameraPosition(target: LatLng(-33.360837, -70.697871), zoom: 15.0);

  final _huellaIcon = Completer<BitmapDescriptor>();

  HomeController() {
    assetToBytes(
      'assets/huella.png',
    ).then(
      (value) {
        final bitmap = BitmapDescriptor.fromBytes(value);
        _huellaIcon.complete(bitmap);
      },
    );
  }

  void onTap(LatLng position) async {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);

    final icon = await _huellaIcon.future;

    final marker = Marker(
        markerId: markerId,
        position: position,
        icon: icon,
        onTap: () {
          _markersController.sink.add(id);
        });
    _markers[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispose() {
    _markersController.close();
    super.dispose();
  }
}
