import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
 
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController guardiannameController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();

  TextEditingController relationshipController = TextEditingController();

  TextEditingController emailController= TextEditingController();
  bool passToggle = true;

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
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                      
                )),
            
            

            Container(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your child\'s name',
              labelText: 'Name',
            
            ),
            
             validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  },
          ),
        ),
           
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: guardiannameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Guardian Name',
                   hintText: 'Enter Guardian Name',
                ),
                validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  },
              ),
            ),
             
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: phonenumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                  hintText: 'Enter your phone number',
                ),
                validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  },
              ),
            ),
             
           
 
Container(
  padding: const EdgeInsets.all(10),
  child: TextFormField(
    controller: relationshipController,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Relationship',
      hintText: 'Enter Relationship with child',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field is required.';
      }
      return null;
    },
  ),
),
 
Container(
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
  child: TextFormField(
    controller: emailController,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Email',
      hintText: 'Enter your email',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field is required.';
      }
      // Regex pattern for email validation
      RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    },
  ),
),
 
Container(
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
  child: TextFormField(
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
  height: 60,
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
  child: ElevatedButton(
    child: const Text('Register'),
    onPressed: () {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String name = nameController.text.trim();
      final String guardianname = guardiannameController.text.trim();
      final String phonenumber = phonenumberController.text.trim();
      final String relationship = relationshipController.text.trim();
      if (email.isEmpty || password.isEmpty || name.isEmpty || guardianname.isEmpty || phonenumber.isEmpty || relationship.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter every field')),
        );
        return;
      }
      FirebaseAuth.instance
  .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
  .then((value) {
    print("Created Account");
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  })
  .onError((error, stackTrace) {
    print("Error ${error.toString()}");
    if (error is FirebaseAuthException && error.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This email is already registered.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  });


    },
  ),
),

 
Row(
  children: <Widget>[
    const Text('Do you have an account?'),
    TextButton(
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 30),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    )
  ]
)
 
          ])
        );
  }
}