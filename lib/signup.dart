import 'dart:developer';

import 'package:dart/main.dart';
import 'package:dart/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController guardiannameController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();

  TextEditingController relationshipController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  bool passToggle = true;

  Future<void> addUserToFirestore(UserModel user, String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    Map<String, dynamic> data = user.toFirestore();
    try {
      await usersCollection.doc(uid).set(data);
      log('User added to Firestore successfully');
    } catch (error) {
      log('Error adding user to Firestore: $error');
    }
  }

  Future<void> addStatusToFirestore(StatusModel user, String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('status');

    Map<String, dynamic> data = user.toFirestore();
    try {
      await usersCollection.doc(uid).set(data);
      log('User added to Firestore successfully');
    } catch (error) {
      log('Error adding user to Firestore: $error');
    }
  }

  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: const Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(padding: const EdgeInsets.all(20), children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              "Create your \nAccount",
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Roboto',
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
                hintText: 'Enter your child\'s name',
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 2),

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: guardiannameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
                labelText: 'Guardian Name',
                hintText: 'Enter Guardian Name',
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 2),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: phonenumberController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
                labelText: 'Phone number',
                hintText: 'Enter your phone number',
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 2),

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: relationshipController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
                labelText: 'Relationship',
                hintText: 'Enter Relationship with child',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 2),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
                labelText: 'Email',
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                // Regex pattern for email validation
                RegExp emailRegex =
                    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 2),

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              obscureText: passToggle,
              controller: passwordController,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                border: InputBorder.none,
                labelText: 'Password',
                hintText: 'Enter your password',
                suffix: InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off),
                ),
                labelStyle: const TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                // Password must be at least 6 characters long
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
          ),

          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 15, bottom: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
                shadowColor: Colors.teal.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: isLoding
                    ? const [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.teal,
                            ),
                          ),
                        )
                      ]
                    : const [
                        Icon(Icons.person_add_alt_1, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Register', style: TextStyle(color: Colors.white)),
                      ],
              ),
              onPressed: () {
                final String email = emailController.text.trim();
                final String password = passwordController.text.trim();
                final String name = nameController.text.trim();
                final String guardianname = guardiannameController.text.trim();
                final String phonenumber = phonenumberController.text.trim();
                final String relationship = relationshipController.text.trim();
                if (email.isEmpty ||
                    password.isEmpty ||
                    name.isEmpty ||
                    guardianname.isEmpty ||
                    phonenumber.isEmpty ||
                    relationship.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.teal,
                        content: Text('Please enter every field')),
                  );
                  return;
                }
                setState(() {
                  isLoding = true;
                });
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) async {
                  final uid = value.user!.uid;
                  await SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('uid', uid);
                  });
                  addUserToFirestore(
                          UserModel(
                            email: emailController.text.trim(),
                            guardianname: guardiannameController.text.trim(),
                            name: nameController.text.trim(),
                            number: phonenumberController.text.trim(),
                            relationship: relationshipController.text.trim(),
                          ),
                          uid)
                      .then((value) {
                    addStatusToFirestore(
                            const StatusModel(
                                age: "Check your status",
                                presentStatus: "Check your status",
                                previousStatus: "Check your status",
                                sex: "Check your status"),
                            uid)
                        .then((value) => setState(() {
                              isLoding = false;

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const Initilize(),
                                  ),
                                  (route) => false);
                            }));
                  });

                  setState(() {
                    isLoding = false;
                  });
                }).onError((error, stackTrace) {
                  log("Error ${error.toString()}");

                  setState(() {
                    isLoding = false;
                  });
                  if (error is FirebaseAuthException &&
                      error.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.teal,
                        content: Text('This email is already registered.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                });
              },
            ),
          ),

          const SizedBox(height: 2),

// The updated code with the applied design:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Do you have an account?",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 5),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.teal,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 2,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ]));
  }
}
