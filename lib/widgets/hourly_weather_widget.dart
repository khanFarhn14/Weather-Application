import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/controllers/global_controller.dart';
import 'package:weather_application/model/weather_data_hourly.dart';
import 'package:weather_application/widgets/style.dart';

// ignore: must_be_immutable
class HourlyWeather extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyWeather({super.key, required this.weatherDataHourly});

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Today's forecast",style: regular()),
        SizedBox(height: 8.h),

        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12 ? 12: weatherDataHourly.hourly.length,
        itemBuilder: (context, index){
          return Obx((() => GestureDetector(
            onTap: (){
              cardIndex.value = index; 
            },
            child: Container(
              width: 80.w,
              margin: EdgeInsets.fromLTRB(0, 0, 12.w, 0),
              padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 12.h),
              decoration: ShapeDecoration(
              color: cardIndex.value == index ? const Color(0xFFC7D7E7) : const Color(0xffC7D7E7).withOpacity(0.5),
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 12,
                  cornerSmoothing: 0.5,
                ),
              ),
              ),

              child: HourlyDetails(
                temp: weatherDataHourly.hourly[index].temp!, 
                timeStamp: weatherDataHourly.hourly[index].dt!, 
                weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                description: weatherDataHourly.hourly[index].weather![0].description!,
              ),
            )
          )));
        },
      )

    );
  }
}

// ignore: must_be_immutable
class HourlyDetails extends StatelessWidget {
  int temp;
  int timeStamp;
  String description;
  String weatherIcon;

  String getTime(final timeStamp){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('jm').format(dateTime);
  }
  
  HourlyDetails({super.key, required this.temp, required this.timeStamp, required this.weatherIcon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(getTime(timeStamp),style: semiRegular()),
        Image.asset("assets/$weatherIcon.png",width: 30.w),
        // Text(description,textAlign: TextAlign.center,style: semiRegular()),
        Text("$temp°", style: semiRegular()),
      ],
    );
  }
}