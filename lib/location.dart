import 'dart:convert';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;



class location {
   late double longitude=0;
  late double latitude=0;

  Future<void> getcurrentlocation() async {
    LocationPermission permission;
    try {
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude= position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
