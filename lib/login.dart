import 'package:firebase_auth/firebase_auth.dart';

import 'forgot.dart';
import 'signup.dart';
import 'home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Nutracker';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
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
                  'Nutracker',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 59, 107),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                )
                ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email ',
                  hintText: 'Enter your mail',
                  
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: passToggle,
                controller: passwordController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off
                    ),
                  )
                ),
              ),
            ),
            TextButton(
             
              child: const Text(
                'Forgot Password?',
              ),
              onPressed:() {
                Navigator.of(context).push(
                   MaterialPageRoute(builder: (ctx)=>Forgot()));
              },
            ),
            Container(
  height: 50,
  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  child: ElevatedButton(
    child: const Text('Login'),
    onPressed: () {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter email and password')),
        );
        return;
      }
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message)),
          );
        });
    },
  ),
),

                            
                
              
                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account?"),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                       MaterialPageRoute(builder: (ctx)=>Signup()));
                  },
                )
              ],
            ),
          ],
        ));
  }
}
