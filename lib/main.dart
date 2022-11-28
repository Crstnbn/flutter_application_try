import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/routes/pages.dart';
import 'package:flutter_application_try/app/ui/pages/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geocoding',

      theme: ThemeData(
        primaryColor: Colors.blue,
      ),

      //home: ProfileDogPage(),
      initialRoute: Routes.PERMISSIONS,
      routes: appRoutes(),
    );
  }
}
