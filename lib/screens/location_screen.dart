import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_challenge/controller/city_notifier.dart';
import 'package:weather_app_challenge/screens/new_city_form.dart';
import 'package:weather_app_challenge/utils/constants.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    final cities = Provider.of<CityNotifier>(context, listen: false).citiesList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff6300B4),
                  Color(0xff5802B7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
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
                    child: buildCity(context, cities),
                  )
                ]),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) /
                    1.3,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewCityForm(),
                      ),
                    );
                  },
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
