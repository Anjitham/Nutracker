import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PageCamera extends StatefulWidget {
  const PageCamera({Key? key}) : super(key: key);

  @override
  _PageCameraState createState() => _PageCameraState();
}

class _PageCameraState extends State<PageCamera> {
  final picker = ImagePicker();
  File? _image;

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 200,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: const Text('Select Image from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImageFromCamera,
              child: const Text('Take a Picture'),
            ),
          ],
        ),
      ),
    );
  }
}
