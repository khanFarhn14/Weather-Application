import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/model/weather_data_daily.dart';
import 'package:weather_application/widgets/style.dart';


class DailyWeather extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    return DateFormat('EEE').format(time);
  }

  const DailyWeather({super.key, required this.weatherDataDaily});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 8.h),
        decoration: ShapeDecoration(
          color: const Color(0xffC7D7E7).withOpacity(0.5),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 12,
              cornerSmoothing: 0.5,
            ),
          )
        ),
        child: Column(
          children: [
            ListDaily(),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ListDaily(){
    return SizedBox(
      height: 270,
      child: ListView.builder(
        itemCount: weatherDataDaily.daily.length > 7 ? 7 : weatherDataDaily.daily.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(getDay(weatherDataDaily.daily[index].dt), style: semiRegular()),
                  Image.asset("assets/${weatherDataDaily.daily[index].weather![0].icon}.png", width: 32.w,),
                  Text("${weatherDataDaily.daily[index].temp?.max}°/${weatherDataDaily.daily[index].temp?.min}",style: semiRegular())
                ],
              ),
              Divider(
                color: secondary.withOpacity(0.5),
                thickness: 0.5,
              ),
            ],
          );
        },
      )
    );
  }
}