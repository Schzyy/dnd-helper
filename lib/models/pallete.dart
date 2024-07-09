import 'package:flutter/material.dart';

class AppProperties {
  static const Color screenColor = Color.fromARGB(255, 0, 0, 0);
  static const Color cardColor = Color.fromARGB(255, 37, 37, 37);
  static const Color cardColor2 = Color.fromARGB(255, 67, 67, 67);
  static const Color cardColor3 = Color.fromARGB(255,123,123,123);

  static const Color enemyRed = Color.fromARGB(255, 223, 54, 77);
  static const Color enemyRedDark = Color.fromARGB(255, 124, 21, 35);

  static const Color allyYellow = Color.fromARGB(255, 225, 173, 39);
  static const Color allyYellowDark = Color.fromARGB(255, 135, 107, 35);

  static const Color heroPurple = Color.fromARGB(255, 132, 91, 245);
  static const Color herpPurpleDark = Color.fromARGB(255, 73, 39, 160);

  static double cardRadius = 20.0;
  static double bRadius = 20;
  
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
