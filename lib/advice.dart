import 'package:dart/answer.dart';
import 'package:flutter/material.dart';

class YesNoQuestionsPage extends StatefulWidget {
  const YesNoQuestionsPage({Key? key}) : super(key: key);

  @override
  State<YesNoQuestionsPage> createState() => _YesNoQuestionsPageState();
}

class _YesNoQuestionsPageState extends State<YesNoQuestionsPage> {
  List<bool> question = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<Qustion> questionList = const [
    Qustion(
        no: "Must provide breastmilk till age of 3.",
        yes: "Must Continue till the age of 3"),
    Qustion(
        no: "Provide semi solid food like ragi, three times per day",
        yes: "Continue including food items rich in proteins like boiled egg"),
    Qustion(
        no:
            " Provide balanced nutritious food like ragi,rice, banana pulp, boiled egg etc. ",
        yes:
            "Continue including balanced nutritious food like ragi,banana pulp, rice etc"),
    Qustion(
        no: "Keep a balanced diet for your child.",
        yes: "Include variety of nutrition rich food ."),
    Qustion(
        no: "Encourage child to take Breakfast on time.",
        yes: "Continue Encouraging to take Breakfast on time."),
    Qustion(
        no: "Take checkups with one month gap.",
        yes: "Continue taking regular check-ups."),
    Qustion(
        no: "Encourage child to drink enough water. \nAge 1 to 3 - four cups of milk or water. \nAge 4 to 5 - five cups of milk or water.",
        yes: "Continue encouraging child to drink water and milk"),
    Qustion(
        no: "Take your shots on time.",
        yes: "Don't compromise on getting immunised."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Questionnaires'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: numer("1"),
              title: const Text(
                  'Does your child under six months have breast milk continuously? '),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[0],
                onChanged: (value) {
                  setState(() {
                    question[0] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("2"),
              title: const Text(
                  'Provide liquid or semi-solid food atleast three times per day in the 1st year of the child?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[1],
                onChanged: (value) {
                  setState(() {
                    question[1] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("3"),
              title: const Text('Each meal contains balanced nutrition foods?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[2],
                onChanged: (value) {
                  setState(() {
                    question[2] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("4"),
              title: const Text(
                  'Are you encouraging your child to take a balanced diet?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[3],
                onChanged: (value) {
                  setState(() {
                    question[3] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("5"),
              title: const Text(
                  'Is your pre-school child taking breakfast daily?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[4],
                onChanged: (value) {
                  setState(() {
                    question[4] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("6"),
              title: const Text('whether or if a child has regular checks?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[5],
                onChanged: (value) {
                  setState(() {
                    question[5] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("7"),
              title: const Text('Has the child gotten enough water to drink?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[6],
                onChanged: (value) {
                  setState(() {
                    question[6] = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: numer("8"),
              title: const Text('Are you correctly providing immunisations?'),
              trailing: Switch(
                activeColor: Colors.teal,
                value: question[7],
                onChanged: (value) {
                  setState(() {
                    question[7] = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: <Color>[Colors.teal, Colors.tealAccent],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      context: context,
                      builder: (context) {
                        List<String> newList = [];

                        for (int i = 0; i < questionList.length; i++) {
                          if (question[i]) {
                            newList.add(questionList[i].yes);
                          } else {
                            newList.add(questionList[i].no);
                          }
                        }

                        return Answer(
                          list: newList,
                        );
                      });
                },
                child: const Text('Advice'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numer(String number) => CircleAvatar(
        backgroundColor: Colors.teal,
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

class Qustion {
  final String yes;
  final String no;

  const Qustion({
    required this.no,
    required this.yes,
  });
}
