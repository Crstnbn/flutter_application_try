import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/routes/pages.dart';
import 'package:flutter_application_try/app/ui/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapas',
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
    );
  }
}
