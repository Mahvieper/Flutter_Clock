import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'clock_body.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  List colors = [Colors.red, Colors.green, Colors.yellow];
  Color color;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 47, 54, 100),
      body: AspectRatio(
          aspectRatio: 5 / 3,
          child: ClockBody()),
    );
  }
}
