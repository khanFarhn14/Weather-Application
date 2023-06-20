import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/screens/home_screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => const GetMaterialApp(
        home: HomeScreen(),
        title: "Weather",
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(390, 844),
    );
  }
}