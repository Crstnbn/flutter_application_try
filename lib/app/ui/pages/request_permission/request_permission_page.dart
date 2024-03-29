import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/request_permission/request_permission_controller.dart';
import 'package:flutter_application_try/app/ui/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({Key? key}) : super(key: key);

  @override
  State<RequestPermissionPage> createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage>
    with WidgetsBindingObserver {
  final _controller =
      RequestPermissionsController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  bool _fromSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = _controller.onStatusChanged.listen(
      (status) {
        switch (status) {
          case PermissionStatus.granted:
            _goThoHome();
            break;
          case PermissionStatus.permanentlyDenied:
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("INFORMACION"),
                content: const Text(
                    "La aplicacion requiere de permisos de ubicacion"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      _fromSettings = await openAppSettings();
                    },
                    child: const Text("Ir a configuraciones"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                ],
              ),
            );
            break;
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("state $state");
    if (state == AppLifecycleState.resumed && _fromSettings) {
      final status = await _controller.check();
      if (status == PermissionStatus.granted) {
        _goThoHome();
      }
    }
    _fromSettings = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _goThoHome() {
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text("Permisos de ubicacion"),
          onPressed: () {
            _controller.request();
          },
        ),
      )),
    );
  }
}
