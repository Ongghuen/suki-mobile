import 'package:flutter/material.dart';

const url = "http://192.168.100.8:8000";
// const url = "http://10.0.2.2:8000";

// url api yang dipake
const apiUrl = url;
const apiUrlStorage = apiUrl + "/storage/";

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
