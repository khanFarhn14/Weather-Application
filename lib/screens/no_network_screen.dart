import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_application/widgets/style.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/wifi bounce.gif",width: 80)),
          SizedBox(height: 8.h),
          Center(child: Text("No Network", style: regular(),)),
          SizedBox(height: 8.h),
          Center(child: Text("Check your Wifi/Mobile Network", style: semiRegular(),))
        ],
      )
    );
  }
}