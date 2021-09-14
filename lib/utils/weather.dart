//import 'dart:html';
library dart.dom.html;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'location.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:flutter_crud/env.sample.dart';
//import 'package:geocoder/geocoder.dart';

const apiKey = '3b7c49f7624c85109e6c98d4ffa52585';


class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon ,@required this.weatherImage});
}


class WeatherData {
  WeatherData({@required this.locationData});


  LocationHelper locationData;
  double currentTemperature;
  double cFeelLikeTemp;
  int currentCondition;
  double currentWindSpeed;
  int cHumidity;
  int cPressure;
  String cName;


  Future<void> getCurrentTemperature() async{

    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric'));

    if(response.statusCode == 200){
      String data = response.body;
      //print(data);
      var currentWeather = jsonDecode(data);
       // print(currentWeather);
      try{
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentWindSpeed = currentWeather['wind']['speed'];
        cHumidity = currentWeather['main']['humidity'];
        cPressure = currentWeather['main']['pressure'];
        cFeelLikeTemp = currentWeather['main']['feels_like'];
        cName = currentWeather['name'];
//
//        // From coordinates
//        final coordinates = new Coordinates(1.10, 45.50);
//        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//        var first = addresses.first;
//        print("${first.featureName} : ${first.addressLine}");

      } catch (e){
        print(e);
      }
    }
    else{
      print('Could not fetch temperature!!!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if(currentCondition < 800){
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size : 80.0,
          ) ,
          weatherImage: AssetImage('assets/cloudy.png'),
      );
    }
    else{
      var now  = new DateTime.now();
      print(now);


      if(now.hour <=7 || now.hour>=19){
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 80.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/night.png'),
        );
      }
      else{
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 80.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/sunny.png'),
        );
      }
    }
  }


}