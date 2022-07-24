import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/perfil_page.dart';

class ReadPage extends StatelessWidget {
  ReadPage({Key? key}) : super(key: key);

  final controller = TextEditingController();
  // final controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Perritos encontrados'),
        ),
        body: FutureBuilder<Profile?>(
          future: readProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Algo salio mal! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final profile = snapshot.data;

              return profile == null
                  ? const Center(child: Text('No hay perfil'))
                  : buildProfile(profile);
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
              MaterialPageRoute(builder: (context) => ProfilePage()),
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

Future<Profile?> readProfile() async {
  // Recibe solo un documento
  final docProfile = FirebaseFirestore.instance
      .collection('profiles')
      .doc('tyOUrIhJfrCEmrA1M9my');
  final snapshot = await docProfile.get();

  if (snapshot.exists) {
    return Profile.fromJson(snapshot.data()!);
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

  static Profile fromJson(Map<String, dynamic> json) =>
      Profile(id: json['id'], name: json['name'], color: json['color']);
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