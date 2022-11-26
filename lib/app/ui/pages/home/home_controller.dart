import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/helpers/asset_to_bytes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  Position? _initialPosition;
  CameraPosition get initalCameraPosition => CameraPosition(
        target: LatLng(
          _initialPosition!.latitude,
          _initialPosition!.longitude,
        ),
        zoom: 15.0,
      );

  final _huellaIcon = Completer<BitmapDescriptor>();
  bool _loading = true;

  bool get loading => _loading;

  late bool _gpsEnable;
  bool get gpsEnable => _gpsEnable;

  StreamSubscription? _gpsSubscription, _positionSubscription;

  HomeController() {
    _init();
  }

  Future<void> _init() async {
    final value = await assetToBytes(
      'assets/huella.png',
    );
    final bitmap = BitmapDescriptor.fromBytes(value);
    _huellaIcon.complete(bitmap);
    _gpsEnable = await Geolocator.isLocationServiceEnabled();
    _loading = false;
    _gpsSubscription = Geolocator.getServiceStatusStream().listen(
      (status) async {
        _gpsEnable = status == ServiceStatus.enabled;
        if (_gpsEnable) {
          _initLocationUpdates();
        }
      },
    );
    _initLocationUpdates();
  }

  Future<void> _initLocationUpdates() async {
    bool initialized = false;
    await _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream().listen(
      (position) {
        print("position $position");
        if (!initialized) {
          _setInitialPosition(position);
          initialized = true;
          notifyListeners();
        }
      },
      onError: (e) {
        print("on Error ${e.runtimeType}");
        if (e is LocationServiceDisabledException) {
          _gpsEnable = false;
          notifyListeners();
        }
        //conflicto getservicestatusstream
      },
    );
  }

  void _setInitialPosition(position) {
    if (_gpsEnable && _initialPosition == null) {
      _initialPosition = position;
    }
  }

  Future<void> turnOnGPS() => Geolocator.openLocationSettings();

  void onTap(LatLng position) async {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final icon = await _huellaIcon.future;

    final marker = Marker(
        markerId: markerId,
        position: position,
        icon: icon,
        onTap: () async {
          _markersController.sink.add(id);
          await FirebaseFirestore.instance.collection('location').add({
            'latitude': position.latitude,
            'longitude': position.longitude,
          });
        });
    _markers[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _gpsSubscription?.cancel();
    _markersController.close();
    super.dispose();
  }
}
