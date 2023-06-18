import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  
  // Initialising variables
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  
  // functions
  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  @override
  void onInit() {
    if(_isLoading.isTrue){
      getLocation();
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
      _isLoading.value = false;
    });

  }
}