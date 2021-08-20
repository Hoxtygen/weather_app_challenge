import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_challenge/controller/city_notifier.dart';
import 'package:weather_app_challenge/screens/location_screen.dart';
import 'package:weather_app_challenge/utils/constants.dart';

class NewCityForm extends StatefulWidget {
  NewCityForm({Key? key}) : super(key: key);
  @override
  _NewCityFormState createState() => _NewCityFormState();
}

class _NewCityFormState extends State<NewCityForm> {
  final FocusNode focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kPurple,
                kBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          cityName = value;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'city name field cannot be blank and must be more than 3 characters long';
                      }
                      return null;
                    },
                    // autofocus: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: "City Name",
                      hintText: "Enter city name",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(350, 50),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<CityNotifier>(context, listen: false)
                          .addCity(cityName);
                      FocusScope.of(context).requestFocus(focusNode);
                      Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) => LocationScreen()));
                    }
                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
