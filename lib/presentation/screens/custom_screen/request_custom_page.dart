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
              child: Text(
                "Custom",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: Center(child: Icon(Icons.abc))),
            Container(color: Colors.black, height: 20,)
          ],
        ),
      ),
    );
  }
}
