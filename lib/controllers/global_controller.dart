import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_application/api/fetch_weather.dart';
import 'package:weather_application/model/weather_data.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';


class GlobalController extends GetxController{
  
  // Initialising variables
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxBool _connectionStatus = true.obs;
  final weatherData = WeatherData().obs;
  
  // functions
  RxBool checkLoading() => _isLoading;
  RxBool checkConnectionStatus() => _connectionStatus;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  WeatherData getWeatherData() => weatherData.value;
  RxInt getIndex() => _currentIndex;

  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;

  @override
  void onInit() {
    connectionStatus();

    if(_isLoading.isTrue && _connectionStatus.isTrue){
      getLocation();
    }
    super.onInit();
  }

  connectionStatus(){
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _connectionStatus.value =
              _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.wifi:
          _connectionStatus.value =
              _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.none:
        default:
          _connectionStatus.value = false;
      }
    }
    );
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

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
  void disposeStream() => _controller.close();
}