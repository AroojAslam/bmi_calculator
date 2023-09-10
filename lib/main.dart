import 'package:flutter/material.dart';
import 'bmi_provider.dart';
import 'main_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> BMIProvider() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BMI Calculator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );

  }
}


