import 'dart:math';
import 'package:flutter/material.dart';

class BMIProvider with ChangeNotifier{
  int height = 180;
  bool result = false;
  String? status;
  double _bmi = 0;
  int weight = 70;
   double get bmi => _bmi;
  double per=0;
  Color color(){
    if (bmi >= 40) {
      return Colors.red.shade900;
    } else if (bmi >= 35) {
      return Colors.orange.shade900;
    } else if (bmi >= 30) {
      return Colors.orange.shade500;
    } else if (bmi >= 25) {
      return Colors.yellow.shade500;
    } else if (bmi >= 18.5) {
      return Colors.green.shade800;
    } else {
      return Colors.blue.shade800;
    }
  }
  void calculateBMI() {
    _bmi = weight / pow((height / 100), 2);
    if (bmi >= 40) {
      status = "Obesity class 3";
    } else if (bmi >= 35) {
      status = 'Obesity class 2';
    } else if (bmi >= 30) {
      status = 'Obesity class 1';
    } else if (bmi >= 25) {
      status = 'Pre-Obesity';
    } else if (bmi >= 18.5) {
      status = 'Normal weight';
    } else {
      status = 'Underweight';
    }
     per= _bmi.roundToDouble()/140;
    notifyListeners();
  }

}