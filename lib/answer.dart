import 'package:flutter/material.dart';


class Answer extends StatelessWidget {
  const Answer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(9, (index) => Padding(
          padding: const  EdgeInsets.all(10),
          child: Text("${index} data"),
        )),
      ),
    );
  }
}
