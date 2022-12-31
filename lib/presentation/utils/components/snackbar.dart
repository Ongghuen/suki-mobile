import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackbar(BuildContext context, text, [label, onPressed]) {
  final snackBar = SnackBar(
    backgroundColor: Colors.grey[850],
    content: Text(text, style: GoogleFonts.montserrat(color: Colors.white),),
    action: SnackBarAction(
      label: label ?? "",
      onPressed: onPressed ?? () {},
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
