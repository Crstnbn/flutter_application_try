import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/photoUpload.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/read_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final controllerName = TextEditingController();
  final controllerColor = TextEditingController();
  // final controllerDescription = TextEditingController();

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
              controller: controllerColor,
              decoration: decoration('color'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                final profile = Profile(
                    name: controllerName.text, color: controllerColor.text);

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
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Anadir imagen del perrito'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PhotoUpload();
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
    final docProfile = FirebaseFirestore.instance.collection('profiles').doc();
    profile.id = docProfile.id;

    final json = profile.toJson();
    await docProfile.set(json);
  }
}

class Profile {
  String id;
  final String name;
  final String color;
  //final DateTime description;

  Profile({
    this.id = '',
    required this.name,
    required this.color,
    //required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color,
        //'description': description,
      };
}


//body: ListView(
  //      children: [
    //      Card(
      //      child: Column(
        //      children: const [
          //      ListTile(
            //      leading: Icon(Icons.photo_album_outlined),
              //    title: Text('nombreperrito'),
                //  subtitle: Text(
                  //    'informacion sobre el perrito, tipo bitacora con toda la informacion del dia a dia del perrito, con la idea de que se pueda modificar siempre sin borrar las otras ediciones'),
                //)
                //Image(image: NetworkImage('http://photos.demandstudios.com/getty/article/18/20/89676742.jpg')
              //],
            //),
          //),
        //],
      //),