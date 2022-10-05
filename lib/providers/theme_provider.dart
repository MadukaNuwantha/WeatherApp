import 'package:flutter/material.dart';
import 'package:weather_app/theme_values.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setWeatherTheme(int weatherCode) async {
    if (weatherCode < 250) {
      // Storm
      _themeData = stormyTheme;
    } else if (250 < weatherCode && weatherCode < 550) {
      // Rain
      _themeData = rainyTheme;
    } else if (550 < weatherCode && weatherCode < 611) {
      // Snow
      _themeData = snowyTheme;
    } else if (550 < weatherCode && weatherCode < 613) {
      // Wind
      _themeData = windyTheme;
    } else if (613 < weatherCode && weatherCode < 760) {
      // Snow
      _themeData = snowyTheme;
    } else if (weatherCode == 800) {
      // Sunny
      _themeData = sunnyTheme;
    } else if (800 < weatherCode) {
      // Cloudy
      _themeData = cloudyTheme;
    }
    notifyListeners();
  }
}
