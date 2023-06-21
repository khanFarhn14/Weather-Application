import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_application/controllers/global_controller.dart';
import 'package:weather_application/screens/no_network_screen.dart';
import 'package:weather_application/widgets/comfort_level.dart';
import 'package:weather_application/widgets/current_weather_widget.dart';
import 'package:weather_application/widgets/daily_weather_widget.dart';
import 'package:weather_application/widgets/header_widget.dart';
import 'package:weather_application/widgets/hourly_weather_widget.dart';
import 'package:weather_application/widgets/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalController controller = Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dominant,
      body: SafeArea(
        child: Obx(
          ()=> controller.checkConnectionStatus().isFalse ? const NoNetwork(): controller.checkLoading().isTrue ? 
          const Center(child: CircularProgressIndicator()): 
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 12.h),
            child: ListView(
              scrollDirection: Axis.vertical,
              children:  [
                SizedBox(height: 48.h,),
                const Header(),
          
                SizedBox(height: 24.h,),
                CurrentWeather(weatherDataCurrent: controller.getWeatherData().getCurrentWeather(),),

                SizedBox(height: 48.h,),
                HourlyWeather(weatherDataHourly: controller.getWeatherData().getHourlyWeather(),),

                SizedBox(height: 48.h,),

                Text("Daily",textAlign: TextAlign.center,style: regular()),
                SizedBox(height: 8.h,),
                DailyWeather(weatherDataDaily: controller.getWeatherData().getDailyWeather(),),

                ComfortLevel(weatherDataCurrent: controller.getWeatherData().getCurrentWeather(),)
              ],
            ),
          )
        ),
      )
    );
  }
}