import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class Signup extends StatefulWidget {
    const Signup({Key? key,}) : super(key: key);

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

  TextEditingController emailController= TextEditingController();
  bool passToggle = true;

  Future addUserDetails(String name, String email, String phonenumber, String guardianname, String relationship) async{
    CollectionReference usersCollectionRef = FirebaseFirestore.instance.collection('users');
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'guardianname' : guardianname,
      'phonenumber' : phonenumber,
      'relationship' : relationship,
      'email' : email
    });
  }

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
              style: TextStyle(fontSize: 20,fontFamily: 'Roboto'),
            ),
          ),
            
            

  Container(
  padding: const EdgeInsets.all(4),
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
  padding: const EdgeInsets.all(4),
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
  padding: const EdgeInsets.all(4),
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
  padding: const EdgeInsets.all(4),
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
  padding: const EdgeInsets.all(4),
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
      RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    },
  ),
),

const SizedBox(height: 2),

Container(
  padding: const EdgeInsets.all(4),
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
          passToggle ? Icons.visibility : Icons.visibility_off
        ),
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
  margin: const EdgeInsets.all(2),
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
      if (email.isEmpty || password.isEmpty || name.isEmpty || guardianname.isEmpty || phonenumber.isEmpty || relationship.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter every field')),
        );
        return;
      }
      FirebaseAuth.instance
  .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
  .then((value) {
    addUserDetails(nameController.text.trim(),
    emailController.text.trim(),
    guardiannameController.text.trim(),
    phonenumberController.text.trim(),
    relationshipController.text.trim());
    print("Created Account");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  })
  .onError((error, stackTrace) {
    print("Error ${error.toString()}");
    if (error is FirebaseAuthException && error.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

 
          ])
        );
  }
}