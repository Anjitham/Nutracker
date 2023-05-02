import 'package:dart/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Input')),
        
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: MyStatefulWidget(),
        ),
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
  String _selectedGender = '';
  final TextEditingController _ageController = TextEditingController();
final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _ageController.dispose(); // dispose of the text field controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^[1-5]$'),
              ),
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
              hintText: 'Enter your child\'s age',
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
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  onPressed: () {
                     if (_formKey.currentState!.validate()) {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CameraPage()),
  );
                     }

                  },
                  child: const Text('Next'),
                  
                ),
              ],
          ),
          ),
      


        
    










        
      ],
    );
  }
}

