// ignore: file_names
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({Key? key}) : super(key: key);

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File sampleImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cargar imagen"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null ? Text("seleccionar imagen") : enableUpload,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Anadir foto",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = 
    await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  Widget enableUpload() {
    return Container
  }
}
