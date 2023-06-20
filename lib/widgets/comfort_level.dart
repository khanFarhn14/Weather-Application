import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_application/model/weather_data_current.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_application/widgets/style.dart';

class ComfortLevel extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const ComfortLevel({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48.h,),
        
        Center(
          child: SleekCircularSlider(
            min: 0,
            max: 100,
            initialValue:  weatherDataCurrent.current.humidity!.toDouble(),

            appearance: CircularSliderAppearance(

              customWidths: CustomSliderWidths(
                handlerSize: 0, trackWidth: 4, progressBarWidth: 8
              ),

              infoProperties: InfoProperties(
                bottomLabelText: "Humidity",
                bottomLabelStyle: semiRegular(),
              ),

              animationEnabled: true,
              size: 150,

              customColors: CustomSliderColors(
                hideShadow: true,
                trackColor: const Color(0xFFACB9C7).withOpacity(0.5),
                progressBarColor: const Color(0xffC7D7E7),
              )
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("UV Index ${weatherDataCurrent.current.uvIndex}",style: semiRegular(),),
            // Horizontal Divider
            Container(
              width: 1.0,
              height: 15,
              color: secondary.withOpacity(0.5),
            ),
            Text("Feels Like:${weatherDataCurrent.current.feelsLike}", style: semiRegular()),
          ],
        ),

        SizedBox(height: 48.h,)
      ],
    );
  }
}