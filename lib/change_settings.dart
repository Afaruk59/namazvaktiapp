import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeSettings with ChangeNotifier {
  //AYARLARI TANIMLAMA
  static late SharedPreferences _settings;

  bool isDark = false;
  MaterialColor color = Colors.blueGrey;
  bool gradient = true;

  static String? cityID;
  static String? cityName;
  static String? cityState;

  bool isfirst = true;

  //AYARLARI DEĞİŞTİREN FONKSİYONLAR

  //VISUAL SETTINGS

  void toggleGrad() {
    gradient = !gradient;
    saveGradtoSharedPref(gradient);
    notifyListeners();
  }

  void loadGradFromSharedPref() {
    gradient = _settings.getBool('gradient') ?? true;
  }

  void saveGradtoSharedPref(bool value) {
    _settings.setBool('gradient', value);
  }

  void toggleTheme() {
    isDark = !isDark;
    saveThemetoSharedPref(isDark);
    notifyListeners();
  }

  Future<void> createSharedPrefObject() async {
    _settings = await SharedPreferences.getInstance();
  }

  void loadThemeFromSharedPref() {
    isDark = _settings.getBool('darkTheme') ?? false;
  }

  void saveThemetoSharedPref(bool value) {
    _settings.setBool('darkTheme', value);
  }

  void changeCol(MaterialColor col) {
    color = col;
    notifyListeners();
  }

  void loadCol() {
    int value = _settings.getInt('color') ?? 0;
    switch (value) {
      case 0:
        color = Colors.blueGrey;
      case 1:
        color = Colors.red;
      case 2:
        color = Colors.blue;
      case 3:
        color = Colors.green;
      case 4:
        color = Colors.yellow;
      case 5:
        color = Colors.amber;
      case 6:
        color = Colors.grey;
      case 7:
        color = Colors.indigo;
      case 8:
        color = Colors.lightBlue;
      case 9:
        color = Colors.lightGreen;
      case 10:
        color = Colors.lime;
      case 11:
        color = Colors.orange;
      case 12:
        color = Colors.pink;
      case 13:
        color = Colors.purple;
      case 14:
        color = Colors.teal;
      case 15:
        color = Colors.brown;
      case 16:
        color = Colors.cyan;
      case 17:
        color = Colors.deepOrange;
      case 18:
        color = Colors.deepPurple;
    }
  }

  void saveCol(MaterialColor color) {
    switch (color) {
      case Colors.blueGrey:
        _settings.setInt('color', 0);
      case Colors.red:
        _settings.setInt('color', 1);
      case Colors.blue:
        _settings.setInt('color', 2);
      case Colors.green:
        _settings.setInt('color', 3);
      case Colors.yellow:
        _settings.setInt('color', 4);
      case Colors.amber:
        _settings.setInt('color', 5);
      case Colors.grey:
        _settings.setInt('color', 6);
      case Colors.indigo:
        _settings.setInt('color', 7);
      case Colors.lightBlue:
        _settings.setInt('color', 8);
      case Colors.lightGreen:
        _settings.setInt('color', 9);
      case Colors.lime:
        _settings.setInt('color', 10);
      case Colors.orange:
        _settings.setInt('color', 11);
      case Colors.pink:
        _settings.setInt('color', 12);
      case Colors.purple:
        _settings.setInt('color', 13);
      case Colors.teal:
        _settings.setInt('color', 14);
      case Colors.brown:
        _settings.setInt('color', 15);
      case Colors.cyan:
        _settings.setInt('color', 16);
      case Colors.deepOrange:
        _settings.setInt('color', 17);
      case Colors.deepPurple:
        _settings.setInt('color', 18);
    }
  }

  //LOCATION SETTINGS
  void loadLocalFromSharedPref() {
    cityID = _settings.getString('location') ?? '16741';
    cityName = _settings.getString('name') ?? 'Merkez';
    cityState = _settings.getString('state') ?? 'İstanbul';
  }

  void saveLocaltoSharedPref(String value, String name, String state) {
    _settings.setString('location', value);
    _settings.setString('name', name);
    _settings.setString('state', state);
    cityID = value;
    cityName = name;
    cityState = state;
  }

  //STARTUP SETTINGS
  void loadFirstFromSharedPref() {
    isfirst = _settings.getBool('startup') ?? true;
  }

  saveFirsttoSharedPref(bool value) {
    _settings.setBool('startup', value);
    notifyListeners();
  }
}
