import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class TextPage extends StatelessWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Informacion sobre tenencia responsable\n de mascotas",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 20.0,
          //fontFamily: 'monospace',
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Padding(
                key: Key('showMore'),
                padding: EdgeInsets.all(20.0),
                child: ReadMoreText(
                  'La Ley de Tenencia Responsable de Mascotas y Animales de Compañía, conocida también como "Ley Cholito", establece una serie de obligaciones que una persona contrae cuando decide aceptar y mantener una mascota o animal de compañía',
                  trimLines: 4,
                  preDataText: "Ley Cholito",
                  preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                  style: TextStyle(color: Colors.black),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '... Mostrar mas',
                  trimExpandedText: ' Mostrar menos',
                ),
              ),
              Divider(
                color: Color(0xFF167F67),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ReadMoreText(
                  'Es el conjunto de obligaciones que contrae una persona cuando decide aceptar y mantener una mascota, es decir, proporcionarle alimento, hogar y buen trato; brindarle los cuidados veterinarios  y no someterlos a sufrimientos; además de respetar las normas de salud y seguridad pública.',
                  trimLines: 4,
                  style: TextStyle(color: Colors.black),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '... Mostrar mas',
                  trimExpandedText: ' Mostrar menos ',
                ),
              ),
              Divider(
                color: Color(0xFF167F67),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ReadMoreText(
                  'Estrategia Nacional Tenencia Responsable de Mascotas como una Herramienta para la Conservación de la Biodiversidad ',
                  trimLines: 4,
                  style: TextStyle(color: Colors.black),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '... Mostrar mas',
                  trimExpandedText: ' Mostrar menos',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
