import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({super.key, required this.list});

  final List list;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              list.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("${index + 1}) ${list[index]}"),
                  )),
        ),
      ),
    );
  }
}
