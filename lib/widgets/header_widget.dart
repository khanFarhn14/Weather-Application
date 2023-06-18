import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_application/controllers/global_controller.dart';
import 'package:geocoding/geocoding.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String city = "";
  final GlobalController controller = Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(controller.getLattitude().value, controller.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(city),
        
      ],
    );
  }
}