import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/controllers/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_application/widgets/style.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String city = "";
  String state = "";
  final GlobalController controller = Get.put(GlobalController(), permanent: true);
  String date = DateFormat("yMMMd").format(DateTime.now());

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
      state = place.country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$city, $state",style: regular()),
        const SizedBox(height: 4,),
        Text(date, style: semiRegular()),
      ],
    );
  }
}