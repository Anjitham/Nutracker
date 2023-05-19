import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dart/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _selectedImage;
  bool _isLoading = false;
  String _responseText = '';





  Future<void> _uploadImage() async {
    try {
      setState(() {
        _isLoading = true;
      });

      String apiUrl = 'http://64.227.136.230:8000/upload/file';
      String fileName = _selectedImage!.path.split('/').last;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: fileName,
        ),
      });


      Response response = await Dio().post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        setState(() {
          _responseText = response.data.toString();
        });
      } else {
        setState(() {
          _responseText = 'Failed to upload image';
        });
      }
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: 200,
                    height: 200,
                  )
                : const Text('No image selected'),
            ElevatedButton(
              onPressed: () {
                _selectImage(ImageSource.gallery);
              },
              child: const Text('Select Image'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
                shadowColor: Colors.teal.withOpacity(0.5),
              ),
              onPressed: () {
                _selectImage(ImageSource.camera);
              },
              child: const Text('Take Image'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
                shadowColor: Colors.teal.withOpacity(0.5),
              ),
              onPressed:
                  _selectedImage != null && !_isLoading ? _uploadImage : null,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(_responseText),
          ],
        ),
      ),
    );
  }
}
