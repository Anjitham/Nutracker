import 'package:flutter/material.dart';

class YesNoQuestionsPage extends StatefulWidget {
  const YesNoQuestionsPage({Key? key}) : super(key: key);

  @override
  _YesNoQuestionsPageState createState() => _YesNoQuestionsPageState();
}

class _YesNoQuestionsPageState extends State<YesNoQuestionsPage> {
  bool _question1 = false;
  bool _question2 = false;
  bool _question3 = false;
  bool _question4 = false;
  bool _question5 = false;
  bool _question6 = false;
  bool _question7 = false;
  bool _question8 = false;
  bool _question9 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaires'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Does your child under six months have breast milk continuously? '),
              trailing: Switch(
                value: _question1,
                onChanged: (value) {
                  setState(() {
                    _question1 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Give immunization protection according to the schedule?'),
              trailing: Switch(
                value: _question2,
                onChanged: (value) {
                  setState(() {
                    _question2 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Did the child got diarrhoea or any other sickness last six months?'),
              trailing: Switch(
                value: _question3,
                onChanged: (value) {
                  setState(() {
                    _question3 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Did the mother have any sickness during the pregnancy?'),
              trailing: Switch(
                value: _question4,
                onChanged: (value) {
                  setState(() {
                    _question4 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Provide liquid or semi-solid food atleast three times per day in the 1st year of the child?'),
              trailing: Switch(
                value: _question5,
                onChanged: (value) {
                  setState(() {
                    _question5 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Did the mother got balanced food during the pregnancy?'),
              trailing: Switch(
                value: _question6,
                onChanged: (value) {
                  setState(() {
                    _question6 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Each meal contains balanced nutrition foods?'),
              trailing: Switch(
                value: _question7,
                onChanged: (value) {
                  setState(() {
                    _question7 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Are you encouraging your child to take a balanced diet?'),
              trailing: Switch(
                value: _question8,
                onChanged: (value) {
                  setState(() {
                    _question8 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Is your pre-school child taking breakfast daily?'),
              trailing: Switch(
                value: _question9,
                onChanged: (value) {
                  setState(() {
                    _question9 = value;
                  });
                  
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


                  },
                  child: const Text('Advice'),
                  
                ),
              ],
          ),
          ),
      


        
    










        
      ],
    
  

          
        ),
      ),
    );
  }
}
