import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_application/api/fetch_weather.dart';
import 'package:weather_application/model/weather_data.dart';

class GlobalController extends GetxController{
  
  // Initialising variables
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  
  // functions
  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  WeatherData getWeatherData() => weatherData.value;
  RxInt getIndex() => _currentIndex;


  final weatherData = WeatherData().obs;

  @override
  void onInit() {
    if(_isLoading.isTrue){
      getLocation();
    }else{
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    
    // Checking if the Device supports location services
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    // If it dosen't support location services
    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Getting the location permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  
    if (locationPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Getting Latitude and Longitude
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      // Calling our Weather API
      return FetchWeatherAPI().processData(value.latitude, value.longitude).then((value){
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

}