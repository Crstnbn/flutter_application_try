import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/perfil_page.dart';
import 'app/ui/pages/home/home_page.dart';
//import 'package:flutter_application_try/app/ui/routes/pages.dart';
//import 'package:flutter_application_try/app/ui/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapas',
      home: const HomePage(),
      routes: {'perfil': (BuildContext context) => PerfilPage()},
      //initialRoute: Routes.SPLASH,
      //routes: appRoutes(),
    );
  }
}
