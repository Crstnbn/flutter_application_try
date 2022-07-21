import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de perrito'),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.photo_album_outlined),
                  title: Text('nombreperrito'),
                  subtitle: Text(
                      'informacion sobre el perrito, tipo bitacora con toda la informacion del dia a dia del perrito, con la idea de que se pueda modificar siempre sin borrar las otras ediciones'),
                )
                //Image(image: NetworkImage('http://photos.demandstudios.com/getty/article/18/20/89676742.jpg')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
