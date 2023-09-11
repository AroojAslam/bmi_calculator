import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../bmi_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final bmiProvider = Provider.of<BMIProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator',style:TextStyle(color: Theme.of(context).primaryColor) )),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Consumer<BMIProvider>(builder: (context, value, child) {
                    return Text(
                        'Height : ${value.height} cm',style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 16)
                    );
                  },),
                ),
              ),
              Consumer<BMIProvider>(builder: (context, value, child) {
                return  Slider(
                  value: value.height.toDouble(),
                  min: 120,
                  max: 220,
                  onChanged: (newValue) {
                    setState(() {
                      value.height = newValue.toInt();
                    });
                  },
                );
              },),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Consumer<BMIProvider>(builder: (context, value, child) {
                      return Text(
                          'Weight : ${value.weight} KG',style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 16)
                      );
                    },)
                ),
              ),
              Consumer<BMIProvider>(builder: (context, value, child) {
                return Slider(
                  value: value.weight.toDouble(),
                  min: 20,
                  max: 200,
                  onChanged: (double newValue) {
                    setState(() {
                      value.weight = newValue.round();
                    });
                  },
                );
              },),
              const SizedBox(height: 10),
              Text(
                'Your BMI',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 20),
             Card(
               elevation: 3,
               margin: EdgeInsets.symmetric(horizontal: 20),
               child: SizedBox(
                 width:MediaQuery.of(context).size.width,
                 child: Column(
                   children: [
                     const SizedBox(height: 20),
                     Consumer<BMIProvider>(builder: (context, value, child) {
                       return  CircularPercentIndicator(
                         progressColor: value.color(),
                         radius: 100,
                         lineWidth: 10,
                         circularStrokeCap: CircularStrokeCap.round,
                         percent: value.per,
                         center: Text(value.bmi.roundToDouble().toString(),style: TextStyle(
                             fontSize: 35,color: value.color()),
                         ),
                       );
                     }),

                     const SizedBox(height: 20),
                     Consumer<BMIProvider>(builder: (context, value, child) {
                       return  value.result
                           ? Text(value.status.toString(),
                           style:
                           TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: value.color()))
                           : Text('');
                     },),
                     const SizedBox(height: 20),
                   ],
                 ),
               ) ,
             ),
              const SizedBox(height: 50),
             Consumer<BMIProvider>(builder: (context, value, child) {
               return  ElevatedButton(
                 onPressed: () {
                   value.calculateBMI();
                   value.result= true;
                 },
                 child: Text('Calculate BMI'),
               );
             },),
            ],
          ),
        ),
      ),
    );
  }
}
