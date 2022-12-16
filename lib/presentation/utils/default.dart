import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// const url = "http://192.168.0.116:8000";
const url = "http://10.0.2.2:8000";

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
  Widget buildViewportChrome(BuildContext context, Widget child,
      AxisDirection axisDirection) {
    return child;
  }
}

BoxDecoration outlineBasic() {
  return BoxDecoration(
    border: Border.all(width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );
}

loading() {
  return Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ));
}

divider() {
  return Divider(
    thickness: 2,
    color: Colors.black54,
  );
}

TextStyle textStyleDefault() {
  return GoogleFonts.montserrat(color: Colors.black);
}

final rupiahConvert = NumberFormat.currency(locale: 'ID');