import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_application/model/weather_data_current.dart';
import 'package:weather_application/widgets/style.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeather({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/${weatherDataCurrent.current.weather![0].icon}.png",width: 64,),

        SizedBox(height: 24.h),
        Text("${weatherDataCurrent.current.temp}°c",style: bigBold()),

        SizedBox(height: 24.h),
        Text("${weatherDataCurrent.current.weather![0].description}",style: regular()),

        SizedBox(height: 48.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Wind
            Column(
              children: [
                Text("Wind",style: regular()),
                SizedBox(height: 8.h),

                Row(
                  children: [
                    Image.asset("assets/wind.png",width: 32,),

                    SizedBox(width: 8.w,),
                    Text("${weatherDataCurrent.current.windSpeed}",style: semiRegular(),),
                  ],
                )
              ],
            ),

            // Horizontal Divider
            Container(
              width: 1.0,
              height: 60,
              color: secondary.withOpacity(0.5),
            ),

            // Clouds
            Column(
              children: [
                Text("Clouds",style: regular()),
                SizedBox(height: 8.h),

                Row(
                  children: [
                    Image.asset("assets/03d.png",width: 32,),

                    SizedBox(width: 8.w,),
                    Text("${weatherDataCurrent.current.clouds}%",style: semiRegular(),),
                  ],
                )
              ],
            ),

            // Horizontal Divider
            Container(
              width: 1.0,
              height: 60,
              color: secondary.withOpacity(0.5),
            ),

            // Humidity
            Column(
              children: [
                Text("Humidity",style: regular()),
                SizedBox(height: 8.h),

                Row(
                  children: [
                    Image.asset("assets/50n.png",width: 32,),

                    SizedBox(width: 8.w,),
                    Text("${weatherDataCurrent.current.humidity}%",style: semiRegular(),),
                  ],
                )
              ],
            ),
          ],
        )

      ],);
  }
}