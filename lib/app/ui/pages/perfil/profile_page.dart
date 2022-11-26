import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/profile_dog_page.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/read_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Anadir perrito'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: decoration('name'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerDescription,
              decoration: decoration('description'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                final profile = Profile(
                    name: controllerName.text,
                    description: controllerDescription.text);

                createProfile(profile);

                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Ver todos los perritos'),
              onPressed: () {
                final route =
                    MaterialPageRoute(builder: (context) => ReadPage());

                Navigator.push(context, route);
              },
            ),
            //const SizedBox(height: 32),
            //ElevatedButton(
            //child: const Text('Anadir imagen del perrito'),
            //onPressed: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) {
            //return const PhotoUpload();
            // }));
            //},
            //),
          ],
        ),
      );
  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );

  Future createProfile(Profile profile) async {
    final docProfile = FirebaseFirestore.instance.collection('profiles').doc();
    profile.id = docProfile.id;

    final json = profile.toJson();
    await docProfile.set(json);
  }
}

class Profile {
  String id;
  final String name;
  final String description;

  Profile({
    this.id = '',
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
