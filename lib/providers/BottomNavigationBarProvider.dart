import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  String _pageTitle = "本日最新";
  String _appActionStr = "刷新";
  bool _showAppActions = true;
  bool _isNavigator = false;

  int get currentIndex => _currentIndex;

  String get pageTitle => _pageTitle;

  String get appActionStr => _appActionStr;

  bool get showAppActions => _showAppActions;

  bool get isNavigator => _isNavigator;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set pageTitle(String str) {
    _pageTitle = str;
    notifyListeners();
  }

  set appActionStr(String str) {
    _appActionStr = str;
    notifyListeners();
  }

  set showAppActions(bool res) {
    _showAppActions = res;
    notifyListeners();
  }

  set isNavigator(bool res) {
    _isNavigator = res;
    notifyListeners();
  }
}
