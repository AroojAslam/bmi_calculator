import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int age = 50;
  double bmi=0;
  int weight = 70;
  int height = 180;
  void calculateBMI() {
    double Weight = double.parse(weight.toString());
    double Height = double.parse(height.toString()) / 100; // Convert height to meters
    double result = Weight / (Height * Height);
    setState(() {
      bmi = result;
    });
  }
  final speedNotifier = ValueNotifier<double>(10);
  final key = GlobalKey<KdGaugeViewState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body:SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              const  Text('Select your height and Weight'),
              SizedBox(height: 20),
              const  SizedBox(height: 10),
              Text(
                'Height : $height cm',
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
              const SizedBox(height: 10),
              Text(
                'Weight : $weight KG',
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
              const  SizedBox(height: 20),
              Text(
                'Your BMI',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const  SizedBox(height: 20),
              Container(
                width: 230,
                height: 230,
                padding: EdgeInsets.all(10),
                child: KdGaugeView(
                  unitOfMeasurement: ' ',
                  unitOfMeasurementTextStyle: TextStyle(fontSize: 25,color:Theme.of(context).primaryColor),
                  speedTextStyle: TextStyle(fontSize: 35,color:Theme.of(context).primaryColor ),
                  minSpeed: 0.0,
                  maxSpeed: 140.0,
                  speed: bmi.ceilToDouble(),
                  animate: true,
                  alertSpeedArray: [40, 80, 90],
                  alertColorArray: [Colors.orange, Colors.indigo, Colors.red],
                  duration: Duration(seconds: 6),
                ),
              ),
              const  SizedBox(height: 20),
              Text('you are underweight',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
              const  SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
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


