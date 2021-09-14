import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mosam/screens/main_screen.dart';
import 'package:mosam/utils/location.dart';
import 'package:mosam/utils/weather.dart';

import 'package:intl/intl.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  LocationHelper locationData;

  Future<void> getLocationData()async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude == null || locationData.longitude == null)
      {
        // todo : Handle no location
      }

    print(locationData.longitude);
    print(locationData.latitude);
    //print(locationData.time);
    var dt = DateTime.fromMillisecondsSinceEpoch(locationData.time.toInt());
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a,  E').format(dt); // 31/12/2000, 10:00 PM
    print(dt);
    print(d12); // dd/mm/yyyy
  }

  void getWeatherData() async{
    // Fetch the location
    await getLocationData();

    // Fetch the current weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null || weatherData.currentWindSpeed ==null || weatherData.cPressure == null ||
          weatherData.cHumidity == null || weatherData.cFeelLikeTemp==null ) {
      // todo: Handle no weather
    }
    
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
          return MainScreen(
            weatherData: weatherData,
          );
    },
    ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple,Colors.blue],
          )
        ),
        child: Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 160.0,
            duration: Duration(milliseconds: 1100),
          ),
        ),
      ) ,

    );
  }
}
