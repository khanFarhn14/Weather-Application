import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/screens/home_screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: "Weather",
      debugShowCheckedModeBanner: false,
    );
  }
}