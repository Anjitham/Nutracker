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
              child: const Text(
                'Enter Your Email',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
  padding: const EdgeInsets.all(5),
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.teal,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  child: TextField(
    keyboardType: TextInputType.emailAddress,
    controller: emailController,
    style: const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter your email',
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      labelText: 'Email',
      labelStyle: TextStyle(
        color: Colors.teal,
        fontSize: 18,
      ),
    ),
  ),
),

const SizedBox(height: 10),

         Container(
  height: 50,
  margin: const EdgeInsets.symmetric(horizontal: 20),
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
      children: const [
        Icon(Icons.lock_open_outlined, color: Colors.white),
        SizedBox(width: 10),
        Text('Reset Password', style: TextStyle(color: Colors.white)),
      ],
    ),
    onPressed: () {
      final String email = emailController.text.trim();
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')),
        );
        return;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset'),
            content: Text('A password reset email has been sent to ${emailController.text}. Please check your email.'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
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
