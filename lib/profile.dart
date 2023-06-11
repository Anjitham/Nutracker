import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel userModel = UserModel();
  String mail = "";
  String profileUrl = "";

  bool _isLoading = false;
  bool _isLoadingStatus = false;
  UserModel? _user;

  Future<void> fetchUserDataFromFirebase() async {
    String? uid;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          mail = user.email.toString();
          uid = user.uid;
          profileUrl = user.photoURL.toString();
          log(mail);
        });
      }
    });
    setState(() {});
  }

  String name = '';
  String number = '';

  String agefire = '';
  String sexfire = '';
  String presentStatusfire = '';
  String previousStatusfire = '';

  Future<UserModel> getUser() async {
    String? uid;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid');
      _isLoading = true;
    });

    try {
      final DocumentSnapshot snapshot =
          await firestore.collection('users').doc(uid).get();

      log(snapshot.id);
      log(snapshot.data().toString());

      setState(() {
        _user = UserModel.fromFirestore(snapshot);
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        name = data?['name'] ?? '';
        number = data?['number'] ?? "0";
      });

      return UserModel.fromFirestore(snapshot);
    } on FirebaseException catch (e) {
      log(e.message.toString());
      return UserModel();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> getStatus() async {
    String? uid;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid');
      _isLoadingStatus = true;
    });

    try {
      final DocumentSnapshot snapshot =
          await firestore.collection('status').doc(uid).get();

      log(snapshot.id);
      log(snapshot.data().toString());

      setState(() {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        agefire = data?['age'] ?? '';
        sexfire = data?['sex'] ?? "";
        presentStatusfire = data?['presentStatus'] ?? '';
        previousStatusfire = data?['previousStatus'] ??"";
      });
    } on FirebaseException catch (e) {
      log(e.message.toString());
    } finally {
      _isLoadingStatus = false;
    }
  }

  String? age;
  String? sex;
  String? presentStatus;
  String? previousStatus;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      age = prefs.getString('age');
      sex = prefs.getString('sex');
      presentStatus = prefs.getString('presentStatus');
      previousStatus = prefs.getString('previousStatus');
    });
  }

  @override
  void initState() {
    fetchUserDataFromFirebase();
    getUser();
    fetchData();
    getStatus();
    super.initState();
  }

  Future<String> getImagePath() async {
    final appDir = await getApplicationDocumentsDirectory();
    const fileName = 'selected_image.jpg';
    final filePath = '${appDir.path}/$fileName';
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 30,
                    maxRadius: 40,
                    child: FutureBuilder<String>(
                      future: getImagePath(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.file(
                                      File(snapshot.data!),
                                      fit: BoxFit.cover,
                                    )));
                          } else {
                            return Text('Image not found');
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator())
                    : Text(
                        name,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  mail,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Phone Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: _isLoading
                    ? SizedBox(
                        height: 15,
                        width: 10,
                        child: Center(child: const LinearProgressIndicator()))
                    : Text(
                        number,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Gender',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: _isLoadingStatus
                    ? SizedBox(
                        height: 15,
                        width: 10,
                        child: Center(child: const LinearProgressIndicator()))
                    : Text(
                        sexfire,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Age',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: _isLoadingStatus
                    ? SizedBox(
                        height: 15,
                        width: 10,
                        child: Center(child: const LinearProgressIndicator()))
                    : Text(
                        agefire,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Previous Status',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: _isLoadingStatus
                    ? SizedBox(
                        height: 15,
                        width: 10,
                        child: Center(child: const LinearProgressIndicator()))
                    : Text(
                        previousStatusfire,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Present Status',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: _isLoadingStatus
                    ? SizedBox(
                        height: 15,
                        width: 10,
                        child: Center(child: const LinearProgressIndicator()))
                    : Text(
                        presentStatusfire,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
