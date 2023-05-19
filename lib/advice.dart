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
  ];

  List<Qustion> questionList = const [
    Qustion(no: "breastfeed till age of 3 ", yes: "Continue till the afe of 3"),
    Qustion(no: "provide immunisation  ", yes: ""),
    Qustion(no: "breastfeed till age of 3 ", yes: "Remove"),
    Qustion(no: "breastfeed till age of 3 ", yes: ""),
    Qustion(
        no: "provide  semi solid food like ragi,3times per day ",
        yes: "continue include food items rich in protein "),
    Qustion(
        no: " provide balanced nutritious food like ragi,rice,banana pulp ",
        yes: "continue"),
    Qustion(no: "chart a balanced diet", yes: "continue"),
    Qustion(no: "provide brkfast daily", yes: "continue"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaires'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                  'Does your child under six months have breast milk continuously? '),
              trailing: Switch(
                value: question[0],
                onChanged: (value) {
                  setState(() {
                    question[0] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  'Give immunization protection according to the schedule?'),
              trailing: Switch(
                value: question[1],
                onChanged: (value) {
                  setState(() {
                    question[1] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  'Did the child got diarrhoea or any other sickness last six months?'),
              trailing: Switch(
                value: question[2],
                onChanged: (value) {
                  setState(() {
                    question[2] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  'Did the mother have any sickness during the pregnancy?'),
              trailing: Switch(
                value: question[3],
                onChanged: (value) {
                  setState(() {
                    question[3] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  'Provide liquid or semi-solid food atleast three times per day in the 1st year of the child?'),
              trailing: Switch(
                value: question[4],
                onChanged: (value) {
                  setState(() {
                    question[4] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Each meal contains balanced nutrition foods?'),
              trailing: Switch(
                value: question[5],
                onChanged: (value) {
                  setState(() {
                    question[5] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  'Are you encouraging your child to take a balanced diet?'),
              trailing: Switch(
                value: question[6],
                onChanged: (value) {
                  setState(() {
                    question[6] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  'Is your pre-school child taking breakfast daily?'),
              trailing: Switch(
                value: question[7],
                onChanged: (value) {
                  setState(() {
                    question[7] = value;
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Qustion {
  final String yes;
  final String no;

  const Qustion({
    required this.no,
    required this.yes,
  });
}
