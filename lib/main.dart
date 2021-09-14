import 'package:flutter/material.dart';
import 'package:mosam/screens/loading_screens.dart';
import 'package:mosam/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home : LoadingScreen(),
    );
  }
}
