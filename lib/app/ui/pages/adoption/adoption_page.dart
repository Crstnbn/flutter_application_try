import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/adoption/adoption_list_.dart';
import 'package:flutter_application_try/app/ui/pages/adoption/adoption_photo.dart';

class AdoptionPage extends StatelessWidget {
  AdoptionPage({Key? key}) : super(key: key);

  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Anadir adopción'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: decoration('Nombre de nuevo dueñ@'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerDescription,
              decoration: decoration('Número de contacto'),
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
              child: const Text('Ver todos las adopciones'),
              onPressed: () {
                final route = MaterialPageRoute(
                    builder: (context) => const AdoptionList());

                Navigator.push(context, route);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Anadir imagen del perrito'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdoptionPhotoUpload();
                }));
              },
            ),
          ],
        ),
      );
  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );

  Future createProfile(Profile profile) async {
    final docProfile = FirebaseFirestore.instance.collection('adoptions').doc();
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
