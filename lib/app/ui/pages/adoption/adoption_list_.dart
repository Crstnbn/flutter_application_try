import 'package:flutter_application_try/app/ui/pages/adoption/adoption_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdoptionList extends StatelessWidget {
  AdoptionList({Key? key}) : super(key: key);

  final controller = TextEditingController();

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
              MaterialPageRoute(builder: (context) => AdoptionPage()),
            );
          },
        ),
      );
}

Widget buildProfile(Profile profile) => ListTile(
      leading: const CircleAvatar(
          child: Image(
        image: NetworkImage(
            'https://cloudfront-us-east-1.images.arcpublishing.com/infobae/3WZJKDUPKJCKLNRBMXKSDGLFPM.jpg'),
      )),
      title: Text(profile.name),
      subtitle: Text(profile.description),
    );

Stream<List<Profile>> readProfiles() => FirebaseFirestore.instance
    .collection('adoptions')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());

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

  static Profile fromJson(Map<String, dynamic> json) => Profile(
      id: json['id'], name: json['name'], description: json['description']);
}
