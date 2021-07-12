import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.blue[200];
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  String themeText = "s";

  onChanged(newColor, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(newColor.hashCode)
        : accentColor = _toMaterialColor(newColor.hashCode);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    primaryColor = _toMaterialColor(prefs.getInt("primaryColor") ?? 0xFF90CAE9);
    accentColor = _toMaterialColor(prefs.getInt("accentColor") ?? 0xFFFFC107);
    notifyListeners();
  }

  MaterialColor _toMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(colorVal),
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF0D47A1),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      themeText = "d";

    else if (tm == ThemeMode.light)
      themeText = "l";
    else if (tm == ThemeMode.system) themeText = "s";
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";
    if (themeText == "d")
      tm = ThemeMode.dark;
    else if (themeText == "l")
      tm = ThemeMode.light;
    else if (themeText == "s") tm = ThemeMode.system;
    notifyListeners();
  }
}
