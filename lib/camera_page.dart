import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  final double bmi;

  const ImageUploadScreen({super.key, required this.bmi});

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

      String apiUrl = 'http://64.227.136.230:8000/upload/';

      List<int> imageBytes = await _selectedImage!.readAsBytes();

      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(imageBytes),
      });

      // FormData formData = FormData.fromMap({
      //   'file': await MultipartFile.fromFile(
      //     _selectedImage!.path,
      //   ),
      // });

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
    double w = MediaQuery.of(context).size.width;

    log(widget.bmi.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectedImage != null
                ? SizedBox(
                    height: w,
                    child: Image.file(
                      _selectedImage!,
                      height: w,
                      fit: BoxFit.contain,
                    ),
                  )
                : SizedBox(
                    height: w,
                    child: const Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.teal,
            ),
            child: IconButton(
              onPressed: () {
                _selectImage(ImageSource.camera);
              },
              icon: const Icon(
                Icons.camera,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.teal,
            ),
            child: IconButton(
              onPressed: () {
                _selectImage(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.browse_gallery,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
