import 'package:flutter/material.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  static const double card = 8.0;
  static const double container = 12.0;
  static const double button = 8.0;
  
  static BorderRadius get cardRadius => BorderRadius.circular(card);
  static BorderRadius get containerRadius => BorderRadius.circular(container);
  static BorderRadius get buttonRadius => BorderRadius.circular(button);
}
