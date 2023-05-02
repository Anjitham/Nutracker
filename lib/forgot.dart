import 'package:dart/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
  Forgot({Key? key}) : super(key: key);


  TextEditingController emailController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
         ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                )),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Enter Your Email',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
          Container(
  height: 60,
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
  child: ElevatedButton(
    child: const Text('Reset Password'),
    onPressed: () {
      final String email = emailController.text.trim();
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid email')),
        );
        return;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset'),
            content: Text('A password reset email has been sent to ${emailController.text}. Please check your email.'),
            actions: [
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text)
                    .then((value) {
                      print("Password Reseted");
                      
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                },
              ),
            ],
          );
        },
      );
    },
  ),
),

           


          ],
        ));
  }
}
