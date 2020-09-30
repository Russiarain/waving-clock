import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockSettings extends ChangeNotifier {
  static const k24HourFormat = '6504559c-3f1f-4cb6-98df-96ed08a45173';
  static const kClockTheme = 'ba1764af-07d4-4228-b8a3-43261e0b341e';

  SharedPreferences _preferences;
  bool _is24HourFormat;
  int _clockTheme;
  void initSettings() async {
    _preferences = await SharedPreferences.getInstance();
    _is24HourFormat = _preferences.getBool(k24HourFormat) ?? true;
    _clockTheme = _preferences.getInt(kClockTheme) ?? 0;
  }

  bool get is24HourFormat => _is24HourFormat;
  ClockTheme get clockTheme => ClockTheme.values[_clockTheme];

  set is24HourFormat(bool val) {
    _is24HourFormat = val;
    _preferences.setBool(k24HourFormat, val);
    notifyListeners();
  }

  set clockTheme(ClockTheme theme) {
    _clockTheme = theme.index;
    _preferences.setInt(kClockTheme, theme.index);
    notifyListeners();
  }
}

enum ClockTheme { dark, blue, orange, pink }
