import 'package:flutter/material.dart';
import 'Clock.dart';

void main() => runApp(new MaterialApp(
      title: 'DigiLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Clock(),
    ));
