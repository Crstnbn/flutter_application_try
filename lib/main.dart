import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/routes/pages.dart';
import 'package:flutter_application_try/app/ui/pages/routes/routes.dart';
import 'package:flutter_application_try/app/ui/pages/text/text_page.dart';
import 'app/ui/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geocoding',
      //home: const MainPage(),
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final pages = [
    const TextPage(),
    const HomePage(),
    const Center(
      child: Text(
        'Page 3',
        style: TextStyle(fontSize: 60),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          height: 60,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          // ignore: prefer_const_literals_to_create_immutables
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.library_books),
              selectedIcon: Icon(Icons.library_books),
              label: 'Leer',
            ),
            const NavigationDestination(
              icon: Icon(Icons.navigation_rounded),
              selectedIcon: Icon(Icons.navigation),
              label: 'Navegar',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      );
}
