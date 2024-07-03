


import 'package:flutter/material.dart';

const Color wColor = Colors.white;
const Color bColor = Colors.black;
const Color sdColor = Colors.black12;
const Color pColor = Color(0xFF1A2733);
// const Color pColor = Color(0xFFF0F3FF);
const Color yColor = Color(0xFF0070F2);
// const Color p1Color = Color(0xFFDDDDDD);
const Color p1Color = Color(0xFF354A5F);
const Color y1Color = Color(0xFF8396A8);
const Color rColor = Color(0xFFB31312);
const Color greenColor = Color(0xFF41B06E);
const Color yellowColor = Color(0xFFFFC94A);


// Color pColor = getPColor(context);

Color getPColor(BuildContext context) {
  // Get the current theme
  ThemeData theme = Theme.of(context);

  // Check the brightness of the theme
  if (theme.brightness == Brightness.dark) {
    // If dark theme, set pColor to a dark color
    return Color(0xFF1A2733); // Dark color
  } else {
    // If light theme, set pColor to a light color
    return Color(0xFFF0F3FF); // Light color
  }
}