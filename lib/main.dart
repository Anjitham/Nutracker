import 'package:dart/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const Login());
  }

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black
    ));
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,

      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
