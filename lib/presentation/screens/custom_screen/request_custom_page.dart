import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRequestPage extends StatefulWidget {
  const CustomRequestPage({Key? key}) : super(key: key);

  @override
  State<CustomRequestPage> createState() => _CustomRequestPageState();
}

class _CustomRequestPageState extends State<CustomRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        // Let's order fresh items for you
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
        child: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_outlined)),
            Text(
              "Request Custom Form",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // form
      Expanded(child: Column(
        children: [
          Center(child: Icon(Icons.abc)),
        ],
      )),

      // button ajukan request
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: InkWell(
          onTap: () async {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AJUKAN REQUEST",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // pay now
              ],
            ),
          ),
        ),
      )
      ],
    ),)
    ,
    );
  }
}
