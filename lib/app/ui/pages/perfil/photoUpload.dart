import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({Key? key}) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File? sampleImage;
  get picker => null;
  String? _myValue;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? const Text("Select an Image")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.platform.getImage(
        source: ImageSource.gallery,
        maxWidth: null,
        maxHeight: null,
        imageQuality: null,
        preferredCameraDevice: CameraDevice.rear);

    setState(() {
      sampleImage = File(tempImage!.path);
    });
  }

  enableUpload() {
    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Image.file(
                sampleImage!,
                height: 300.0,
                width: 600.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  return value!.isEmpty ? "Description is Required" : null;
                },
                onSaved: (value) => _myValue = value!,
              ),
              const SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                elevation: 10.0,
                textColor: Colors.white,
                color: Colors.red,
                onPressed: validateAndSave,
                child: const Text("Add a New Post"),
              )
            ],
          ),
        ),
      ),
    ));
  }

  bool validateAndSave() {
    final Form = formKey.currentState;
    if (Form!.validate()) {
      Form.save();
      return true;
    } else {
      return false;
    }
  }
}
