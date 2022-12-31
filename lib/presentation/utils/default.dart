import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// const url = "http://192.168.0.103:8000";
// const url = "http://10.0.2.2:8000";
const url = "https://sukifurniture.herokuapp.com";

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

BoxDecoration outlineBasic() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 1, color: Colors.black26),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );
}

BoxDecoration productBox() {
  return BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(20));
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
    color: Colors.black38,
  );
}

TextStyle textStyleDefault() {
  return GoogleFonts.montserrat(color: Colors.black);
}

TextStyle notFoundText() {
  return GoogleFonts.montserrat(fontWeight: FontWeight.w300);
}

getAdaptiveTextSize(BuildContext context, dynamic value) {
  // 720 is medium screen height
  return (value / 720) * MediaQuery.of(context).size.height;
}

statusColorizer(String status){
  Color color = Colors.black;
  switch(status){
    case "Menunggu_Konfirmasi": {
      color = Colors.grey;
    }
    break;
    case "Terkonfirmasi": {
      color = Colors.deepOrange;
    }
    break;
    case "Dikirim": {
      color = Colors.blue;
    }
    break;
    case "Selesai": {
      color = Colors.green;
    }
    break;
    case "Belum_Bayar": {
      color = Colors.red;
    }
    break;
    case "Pending": {
      color = Colors.orangeAccent;
    }
    break;
  }
  return color;
}

final rupiahConvert = NumberFormat.currency(locale: 'ID');
