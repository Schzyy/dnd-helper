import 'package:flutter/material.dart';

class Updater extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}