import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/adoption/adoption_page.dart';

class AdoptionList extends StatelessWidget {
  const AdoptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Perritos encontrados'),
        ),
        body: StreamBuilder<List<Profile>>(
          stream: readAdoption(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Algo salio mal! o no hay datos ${snapshot.error}');
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
              MaterialPageRoute(builder: (context) => AdoptionPage()),
            );
          },
        ),
      );
}

Widget buildProfile(Profile profile) => ListTile(
      leading: CircleAvatar(child: Text('${profile.color}')),
      title: Text(profile.name),
    );

Stream<List<Profile>> readAdoption() => FirebaseFirestore.instance
    .collection('adoptions')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());

class Profile {
  String id;
  final String name;
  final String color;

  Profile({
    this.id = '',
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color,
      };

  static Profile fromJson(Map<String, dynamic> json) =>
      Profile(id: json['id'], name: json['name'], color: json['color']);
}
