import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/adoption/adoption_page.dart';
import 'package:flutter_application_try/app/ui/pages/request_permission/request_permission_page.dart';
import 'package:flutter_application_try/app/ui/pages/text/text_page.dart';

class NatigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NatigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: Colors.black54,
        child: InkWell(
          onTap: () {
            //Navigator.pop(context);
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TextPage(),
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.lightBlueAccent,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Name User',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Text(
                  'User@mail.com',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 30,
          children: [
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const RequestPermissionPage(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.text_fields_rounded),
              title: const Text('Textos informativos'),
              //push para la flecha de volver
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TextPage(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Registrar adopcion'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AdoptionPage(),
                ),
              ),
            ),
            const Divider(
              color: Colors.black54,
            ),
            //linea divisora
            ListTile(
              leading: const Icon(Icons.miscellaneous_services),
              title: const Text('Configuraciones'),
              onTap: () {},
            ),
          ],
        ),
      );
}
