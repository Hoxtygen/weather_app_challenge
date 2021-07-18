import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter/material.dart';

class Location {
  Location({this.latitude, this.longitude});
  double? latitude;
  double? longitude;

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Please put on your location");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied");
      }
    }

    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "Location permission denied forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // latitude = position.latitude;
    // longitude = position.longitude;
    /* catch (error) {
      print("Location Denied Error:${error.toString()}");
      print("Location Denied Error Object:${error}");
      Fluttertoast.showToast(msg: error.toString());
      return error;
      // example snackBar

    } */
  }
}
