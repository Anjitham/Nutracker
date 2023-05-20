import 'dart:ui';

import 'package:flutter/material.dart';

class AlerWidgets extends StatefulWidget {
  final String bmi;
  const AlerWidgets({
    required this.bmi,
    super.key,
  });

  @override
  State<AlerWidgets> createState() => _AlerWidgetsState();
}

class _AlerWidgetsState extends State<AlerWidgets> {
  // final VoidCallback onTap;
  bool intial = false;

  initialTimer() async {
    await Future.delayed(
      const Duration(
        milliseconds: 1,
      ),
    );
    setState(() {
      intial = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initialTimer();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        color: const Color(0xff030927).withOpacity(0.6),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Container(
            height: w,
            width: w * 0.8,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Expanded(
                    child: SizedBox(
                  width: double.maxFinite,
                  child: Stack(children: [
                    circle(20, 54, 226, intial),
                    circle(3, 123, 245, intial),
                    circle(11, 180, 230, intial),
                    circle(8, 226, 187, intial),
                    circle(3, 225, 135, intial),
                    circle(5, 212, 86, intial),
                    circle(5, 160, 60, intial),
                    circle(15, 70, 50, intial),
                    circle(5, 40, 150, intial),
                    Center(
                      child: AnimatedContainer(
                          curve: Curves.fastOutSlowIn,
                          duration: const Duration(milliseconds: 800),
                          height: intial ? 100 : 5,
                          width: intial ? 100 : 5,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.9)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(300),
                          ),
                          child: Icon(
                            Icons.done,
                            size: intial ? 40 : 0,
                            color: Colors.teal,
                            weight: 3000,
                          )),
                    )
                  ]),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    "Your BMI : ${widget.bmi}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    "Thank you ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(color: Colors.teal),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget circle(double radius, double top, double right, bool intial) =>
    AnimatedPositioned(
      top: intial ? top : 130,
      right: intial ? right : 130,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      width: intial ? radius : 0,
      height: intial ? radius : 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
      ),
    );
