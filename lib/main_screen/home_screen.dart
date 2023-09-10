import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:provider/provider.dart';

import '../bmi_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool result = false;
  int age = 50;
  String? status;
  double bmi = 0;
  int weight = 70;
  int height = 180;
  void calculateBMI() {
    setState(() {
      bmi = weight / pow((height / 100), 2);
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
    });
  }

  final speedNotifier = ValueNotifier<double>(10);
  final key = GlobalKey<KdGaugeViewState>();
  @override
  Widget build(BuildContext context) {
    final bmiProvider = Provider.of<BMIProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
               Text('Select your height and Weight',style: TextStyle(color: Theme.of(context).primaryColor,
                   fontSize: 20,
               fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.all(20),
                elevation: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Height : $height cm',style: TextStyle(color: Theme.of(context).primaryColor)
                        ),
                      ),
                    ),
                    Slider(
                      value: height.toDouble(),
                      min: 120,
                      max: 220,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Weight : $weight KG',style: TextStyle(color: Theme.of(context).primaryColor)
                        ),
                      ),
                    ),
                    Slider(
                      value: weight.toDouble(),
                      min: 20,
                      max: 200,
                      onChanged: (double newValue) {
                        setState(() {
                          weight = newValue.round();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your BMI',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 230,
                      height: 230,
                      padding: EdgeInsets.all(10),
                      child: KdGaugeView(
                        unitOfMeasurement: ' ',
                        unitOfMeasurementTextStyle: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColor),
                        speedTextStyle: TextStyle(
                            fontSize: 35,
                            color: Theme.of(context).primaryColor),
                        minSpeed: 0.0,
                        maxSpeed: 90.0,
                        speed: bmi.sign,
                        animate: true,
                        alertSpeedArray: [18.5, 25.0, 30.0, 35.0, 40, 90],
                        alertColorArray: [
                          Colors.blue.shade400,
                          Colors.green.shade600,
                          Colors.yellow,
                          Colors.orange.shade400,
                          Colors.orange.shade600,
                          Colors.red.shade900
                        ],
                        duration: Duration(seconds: 3),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              result
                  ? Text(status.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color: Theme.of(context).primaryColor))
                  : Text(''),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    result = true;
                  });
                  calculateBMI();
                },
                child: Text('Calculate BMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
