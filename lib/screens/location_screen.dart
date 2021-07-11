import 'package:flutter/material.dart';
import 'package:weather_app_challenge/services/weather.dart';
import 'package:weather_app_challenge/utils/constants.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Manage City"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
        ),
        body: Container(
          // color: Colors.blueAccent,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPurple, kBlue,],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Text('I am going to contain cities'),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {},
                  child: const Text('Bottom Button!',
                      style: TextStyle(fontSize: 20)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
