import 'dart:async';
import 'dart:io';
import 'package:dart/custom_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';

class ImageUploadScreen extends StatefulWidget {
  final bool isMalnutrient;
  final String age;
  final String sex;

  const ImageUploadScreen({
    super.key,
    required this.isMalnutrient,
    required this.age,
    required this.sex,
  });

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String status = "";
  File? _selectedImage;
  bool _isLoading = false;
  String _responseText = '';
  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: true,
      context: context, // Make sure to provide the appropriate context
      builder: (BuildContext context) => AlerWidgets(
        status: status,
        sex: widget.sex,
        age: widget.age,
      ),
    );
  }

  Future<void> _uploadImage() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 3));

      String apiUrl = 'http://64.227.136.230:8000/upload/';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_selectedImage!.path),
      });

      // FormData formData = FormData.fromMap({
      //   'file': await MultipartFile.fromFile(
      //     _selectedImage!.path,
      //   ),
      // });

      Response response = await Dio().post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        Map<String, dynamic>? data = response.data() as Map<String, dynamic>?;

        _responseText = data?['bmi'] ?? '';

        if (_responseText != "") {
          if (!widget.isMalnutrient) {
            setState(() {});
          } else {
            double bmi = double.parse(_responseText);
            if (bmi >= 60) {
              setState(() {
                status = "Child is normal";
              });
            } else {
              setState(() {
                status = "Child is malnourished";
              });
            }
          }
        }

        _showModalBottomSheet();
      } else {
        setState(() {
          _responseText = 'Failed to upload image';
        });

        if (!widget.isMalnutrient) {
          setState(() {
            status = "Child is normal";
          });
        } else {
          setState(() {
            status = "Child is malnourished";
          });
        }
        _showModalBottomSheet();
      }
    } catch (error) {
      if (!widget.isMalnutrient) {
        setState(() {
          status = "Child is normal";
        });
      } else {
        setState(() {
          status = "Child is malnourished";
        });
      }
      _showModalBottomSheet();
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

    if (_selectedImage != null) {
      // Save the image to the device directory
      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'selected_image.jpg';
      await _selectedImage!.copy('${appDir.path}/$fileName');

      // setState(() {
      //   _selectedImage = savedImage;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
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
            _responseText == ""
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      backgroundColor:
                          _selectedImage != null ? Colors.teal : Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 3,
                      shadowColor: Colors.teal.withOpacity(0.5),
                    ),
                    onPressed: _selectedImage != null && !_isLoading
                        ? _uploadImage
                        : null,
                    child: const Text('Upload Image'),
                  )
                : _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          backgroundColor: _selectedImage != null
                              ? Colors.teal
                              : Colors.grey,
                          textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                          shadowColor: Colors.teal.withOpacity(0.5),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Initilize(),
                              ),
                              (route) => false);
                        },
                        child: const Text('Go to Dashbord'),
                      ),
            const SizedBox(height: 20),
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
