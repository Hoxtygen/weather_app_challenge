import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Text("Santosa"),
        Column(children: [
          Text("37"),
          Text("Mostyly Sunny")
        ],)
      ],),
    );
  }
}