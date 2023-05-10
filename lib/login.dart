import 'package:dart/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot.dart';
import 'signup.dart';
import 'home.dart';
import 'package:flutter/material.dart';

void main() => runApp( MyApp());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Nutracker';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Scaffold(
        
        body: MyStatefulWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'NuTracker',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.teal,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20,fontFamily: 'Roboto'),
            ),
          ),
          
          Container(
  padding: const EdgeInsets.all(10),
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
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
        Icon(Icons.login, color: Colors.white),
        SizedBox(width: 10),
        Text('Login', style: TextStyle(color: Colors.white)),
      ],
    ),
    onPressed: () {
      // Login button behavior
       final String email = emailController.text.trim();
                final String password = passwordController.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter email and password')),
                  );
                  return;
                }
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
 MaterialPageRoute(builder: (context) => const HomePage()));
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message)),
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
        foregroundColor: Colors.teal, backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 2,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) =>  const Signup()),
        );
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  ],
),

          ],
        ));
  }
}
