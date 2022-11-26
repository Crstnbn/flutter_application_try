import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/profile_dog_page.dart';

class ReadPage extends StatelessWidget {
  ReadPage({Key? key}) : super(key: key);

  final controller = TextEditingController();
  // final controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Perritos encontrados'),
        ),
        body: StreamBuilder<List<Profile>>(
          stream: readProfiles(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Algo salio mal! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final profiles = snapshot.data!;

              return ListView(
                children: profiles.map(buildProfile).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProfileDogPage()),
            );
          },
        ),
      );
}

Widget buildProfile(Profile profile) => ListTile(
      leading: CircleAvatar(child: Text('${profile.color}')),
      title: Text(profile.name),
    );

Stream<List<Profile>> readProfiles() => FirebaseFirestore.instance
    .collection('profiles')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());

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

  static Profile fromJson(Map<String, dynamic> json) =>
      Profile(id: json['id'], name: json['name'], color: json['color']);
}
