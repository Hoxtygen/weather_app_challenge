import 'package:flutter/material.dart';
import 'package:weather_app_challenge/utils/constants.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    List city = [
      "Lagos",
      "Lisbon",
      "London",
    ];
    return SafeArea(
      child: Scaffold(
        //  extendBodyBehindAppBar: true,
        // backgroundColor:Colors.transparent,

        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xff6300B4), Color(0xff5802B7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          title: Text("Manage City"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kPurple,
                kBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Container(
                child: Column(children: [
                  Expanded(
                    child: buildCity(city),
                  )
                ]),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) /
                    1.3,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.1),
                    // onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(350, 50),
                    elevation: 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'ADD CITY',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
