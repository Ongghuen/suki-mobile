import 'package:flutter/material.dart';

const url = "http://192.168.100.20:8000";
// const url = "http://10.0.2.2:8000";

// url api yang dipake
const apiUrl = url;
const apiUrlStorage = "$apiUrl/storage/";

// ini buat ngetruncate text abis itu ditambahin ...
// self-explanatory sih ini sebenernya
String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

// ini buat scroll gada glow
class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
