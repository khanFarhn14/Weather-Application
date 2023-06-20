import 'package:weather_application/model/weather_data_daily.dart';
import 'package:weather_application/model/weather_data_hourly.dart';

import 'weather_data_current.dart';

class WeatherData{
  final WeatherDataCurrent? weatherDataCurrent;
  final WeatherDataHourly? weatherDataHourly;
  final WeatherDataDaily? weatherDataDaily;

  WeatherData([this.weatherDataCurrent, this.weatherDataHourly, this.weatherDataDaily]);

  WeatherDataCurrent getCurrentWeather() => weatherDataCurrent!;
  WeatherDataHourly getHourlyWeather() => weatherDataHourly!;
  WeatherDataDaily getDailyWeather() => weatherDataDaily!;
}