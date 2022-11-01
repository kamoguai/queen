import 'package:flutter/material.dart';

class SearchFilterWidgetProvider extends ChangeNotifier {
  String _inputText = "";

  String get inputText => _inputText;

  set inputText(String str) {
    _inputText = str;
    notifyListeners();
  }
}
