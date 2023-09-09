import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor ,
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
            const  Text('Select your height and Weight'),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.05),
                border: Border.all(color:Theme.of(context).primaryColor.withOpacity(0.7),
                    width: 2),
                borderRadius: BorderRadius.circular(20),

                ),
                child: Column(
                  children: [
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
                  ]
                ),
              ),


              Text(
                'Your BMI is:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
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



