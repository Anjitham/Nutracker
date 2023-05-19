import 'package:dart/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot.dart';
import 'signup.dart';
import 'home.dart';
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passToggle = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text(
          'NuTracker',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 30),
                  child: Text(
                    "Login to your \nAccount",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Roboto',
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "We're glad to have you back. Please enter your email to proceed.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.5),
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
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
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
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.teal,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: passToggle,
                    controller: passwordController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Forgot(),
                    ));
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                  
                   ElevatedButton(
                    style:
                    
                     ElevatedButton.styleFrom(
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
                      children: isLoading
                          ? [
                              const SizedBox(
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
                              Icon(Icons.login, color: Colors.white),
                              SizedBox(width: 10),
                              Text('Login',
                                  style: TextStyle(color: Colors.white)),
                            ],
                    ),
                    onPressed: () {
                      // Login button behavior
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                             backgroundColor: Colors.teal,
                              content: Text('Please enter email and password')),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });

                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                      }).catchError((error) {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.teal,
                              content: Text(error.message)),
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't have an account?",
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const Signup()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
