import 'dart:async';


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Obtain a list of available cameras on the device.
    final cameras = availableCameras();

    // Initialize the camera controller once the camera is available.
    _initializeControllerFuture = cameras.then((cameras) {
      // Get the first camera in the list.
      final camera = cameras.first;

      // Create a CameraController instance and start it.
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      return _controller.initialize();
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();

    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Construct the path where the image should be saved using the
      // path_provider package.
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/image.png';

      // Take a picture and save it to filePath.
      

      
    } catch (e) {
      // An error occurred while taking the picture.
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


