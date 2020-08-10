import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.lightGreenAccent,
    accentColor: Colors.green,
    scaffoldBackgroundColor: Colors.lightGreenAccent[100],
    textTheme: TextTheme(
      body1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
      ),
      body2: TextStyle(
        fontSize: 16.0,
      ),
    ),
  );
}