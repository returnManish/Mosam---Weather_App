import 'package:flutter/material.dart';
import 'package:location/location.dart';


class LocationHelper {
  double latitude;
  double longitude;
  double time;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check whether we have permissions for the location
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // If permissions are not there, return
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // If permissions are there, find the location and store the longitude and latitude
    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
    time = _locationData.time;
//    var dt = DateTime.fromMillisecondsSinceEpoch(_locationData.time.toInt());
//    var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM
  }
}