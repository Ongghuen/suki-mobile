import 'package:flutter/material.dart';

// const urlNetwork = "http://192.168.100.12:8000";
const urlEmu = "http://10.0.2.2:8000";

// url api yang dipake
const apiUrl = urlEmu;
const apiUrlStorage = apiUrl + "/storage/";

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}