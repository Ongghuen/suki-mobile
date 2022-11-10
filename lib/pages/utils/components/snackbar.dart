import 'package:flutter/material.dart';

showSnackbar(BuildContext context, text, [label, onPressed]) {
  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: label ?? "",
      onPressed: onPressed ?? () {},
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
