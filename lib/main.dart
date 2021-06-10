import 'package:flutter/material.dart';

const purple = Color.fromRGBO(100, 12, 170, 1);
const blue = Color.fromRGBO(0, 9, 234, 0.79);
const greenGradient = LinearGradient(
  colors: [
    Color.fromRGBO(140, 255, 144, 1),
    Color.fromRGBO(133, 255, 233, 1),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(),
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello World"),
    );
  }
}
