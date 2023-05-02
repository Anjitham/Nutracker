import 'package:dart/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'profile.dart';
import 'advice.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
  margin: const EdgeInsets.all(8.0),
            child: SizedBox(
             width: 132,
             height: 50,
           child: ElevatedButton(
               style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: const Size(120, 40), //////// HERE
            ),
              
              onPressed: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Profile()),
  );
               },

              child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.person,size: 30,), // add icon
      SizedBox(width: 10), // add some spacing
      Text('Profile'), // add text
    ],
  ),
            ),

            ),
        ),
        Container(
  margin: const EdgeInsets.all(8.0),

            child: SizedBox(
             width: 132,
             height: 50,
            child: ElevatedButton(
               style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: const Size(100, 40), //////// HERE
            ),
              
              onPressed: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Input()),
  );
                // handle button B press
              },
              child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.assignment,size: 30,), // add icon
      SizedBox(width: 10), // add some spacing
      Text('Input'), // add text
    ],
  ),
            ),
            ),
        ),
            

            Container(
  margin: const EdgeInsets.all(8.0),
            child: SizedBox(
             width: 132,
             height: 50,
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: const Size(100, 40), //////// HERE
            ),
              
              onPressed: () {

                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const YesNoQuestionsPage()),
  );
                // handle button E press
              },
              child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.menu_book,size: 30,), // add icon
      SizedBox(width: 10), // add some spacing
      Text('Advice'), // add text
    ],
  ),
            ),
            ),
            ),
 
            Container(
  margin: const EdgeInsets.all(8.0),

           child: SizedBox(
             width: 132,
             height: 50,
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: const Size(100, 40), //////// HERE
            ),
              
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (ctx) => const Login())
                );// handle button E press

                });
                 
              },
              child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.logout,size: 30,), // add icon
      SizedBox(width: 10), // add some spacing
      Text('Logout'), // add text
    ],
  ),
            ),
            ),
            ),


    
          ],
        ),
      ),
    );
  }
}
