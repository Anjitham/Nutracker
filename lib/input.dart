import 'dart:developer';

import 'package:dart/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Fill the Details'),
        backgroundColor: Colors.teal,
      ),
      body: const SingleChildScrollView(
        child: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _selectedGender = 'boy';
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    // dispose of the text field controller
    super.dispose();
  }

  Future<void> addUserInput() {
    return users
        .doc('email') // Replace with the user ID
        .collection('inputs')
        .add({
          'age': _ageController.text,
          'gender': _selectedGender,
          'height': _heightController.text,
          'weight': _weightController.text,
        })
        .then((value) => log("User input added"))
        .catchError((error) => log("Failed to add user input: $error"));
  }

 

  bool determineMalnutritionStatus(int age, double height, double weight) {
    // Mean height and weight values for each age group
    final meanHeight = [73.5, 85.0, 94.0, 101.5];
    final meanWeight = [9.5, 12.0, 14.0, 16.0];

    // Standard deviation values for height and weight (assumed constant for all age groups)
    const heightSD = 4.0;
    const weightSD = 1.5;

    // Age group index (to access meanHeight and meanWeight arrays)
    final ageIndex = age - 1;

    // Calculate the z-scores for height and weight
    final heightZScore = (height - meanHeight[ageIndex]) / heightSD;
    final weightZScore = (weight - meanWeight[ageIndex]) / weightSD;

    // Define the malnutrition threshold as -2 standard deviations
    // but i choosed -3

    const malnutritionThreshold = -3.0;

    // Determine if the child is malnourished or not
    if (heightZScore < malnutritionThreshold ||
        weightZScore < malnutritionThreshold) {
      log("Child is malnourished");

      log(heightZScore.toString());
      log(weightZScore.toString());

      return true; // Child is malnourished
    } else {
      log("Child is normal");

      log(heightZScore.toString());
      log(weightZScore.toString());

      return false; // Child is normal
    }
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('age', _ageController.text);
    await prefs.setString('sex', _selectedGender);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-4](\.\d{0,1})?$')),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                  hintText: 'Enter a number between 0 and 5',
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required.';
                  }
                  final numValue = double.tryParse(value);
                  if (numValue == null || numValue < 0 || numValue > 5) {
                    return 'Enter a number between 0 and 5';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Gender:'),
                  ListTile(
                    leading: Radio<String>(
                      value: 'boy',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    title: const Text(
                      'Boy',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'girl',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    title: const Text(
                      'Girl',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Height',
                  hintText: 'Enter your child\'s Height in cm',
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight',
                  hintText: 'Enter your child\'s weight in kg',
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF26A69A),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                  shadowColor: const Color(0xFF26A69A).withOpacity(0.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Next', style: TextStyle(color: Colors.white)),
                  ],
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    

                    addUserInput().then((value) {
                     

                      saveData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageUploadScreen(
                            isMalnutrient:determineMalnutritionStatus(
                        int.parse(_ageController.value.text.trim()),
                        double.parse(_heightController.value.text.trim()),
                        double.parse(_weightController.value.text.trim())),
                            age: _ageController.value.text.trim(),
                            sex: _selectedGender,
                          ),
                        ),
                      );
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
