
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosam/utils/weather.dart';

import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class MainScreen extends StatefulWidget {

  MainScreen({@required this.weatherData});

  final WeatherData weatherData;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  var now;
  var nowF;
  int feelsLikeT;
  double cWindSpeed;
  int chumidity;
  int cpressure;
  String cityName;

  void updateDisplayInfo(WeatherData weatherData){

    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData = weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      now  = new DateTime.now();
      nowF = DateFormat('dd/MM/yyyy, hh:mm a,  EEEE').format(now);
      feelsLikeT = weatherData.cFeelLikeTemp.round();
      cWindSpeed = weatherData.currentWindSpeed;
      chumidity = weatherData.cHumidity;
      cpressure = weatherData.cPressure;
      cityName = weatherData.cName;
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Work In Progress"),
          content: new Text("Developer:- MANISH 😎"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
              ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                      '$temperature°c',
                         style: TextStyle(
                           fontSize: 80.0,
                           color: Colors.white,
                           letterSpacing: -5,
                         ),
                  ),
                ),
                     SizedBox(
                       width: 20.0,
                     ),
                     Text(
                  'Feels Like $feelsLikeT°c',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9.0,
            ),
            Center(
              child: Text(
                '$nowF',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueGrey[400],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(
              height: 9.0,
            ),
            Center(
              child: Text(
                '$cityName',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.blueGrey[300],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black45,
                    borderRadius: BorderRadius.circular(15)
                  ),

                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 28),
                  child: Column(
                    children: [
                      Icon( WeatherIcons.humidity,
                        color: Colors.blue[200],
                        size: 40.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("Humidity"),
                      Text('$chumidity%',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(15)
                  ),

                  padding: EdgeInsets.symmetric(vertical: 60,horizontal: 12),//30,7
                  child: Column(
                    children: [
                      Icon( FontAwesomeIcons.wind,
                        color: Colors.lightBlue[700],
                        size: 40.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("Wind"),
                      Text(
                          '$cWindSpeed km/h',
                        style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                ),
                Container(
                //  color: Colors.black87,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(15)
                  ),

                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 1),
                  child: Column(
                    children: [
                      Icon(WeatherIcons.barometer ,
                        color: Colors.deepOrange,
                        size: 40.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text('Pressure'),
                      Text('$cpressure h'
                          'Pa',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_showDialog();},

        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.android,
          color: Colors.black,
        ),
      ),
    );


  }
}
