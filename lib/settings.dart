import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockSettings extends ChangeNotifier {
  static const k24HourFormat = '6504559c-3f1f-4cb6-98df-96ed08a45173';
  static const kClockTheme = 'ba1764af-07d4-4228-b8a3-43261e0b341e';
  static const kShowAmPm = '0a30b9fa-e1b9-478d-88d9-31a1d4e7ffff';

  ClockSettings(this._preferences);

  SharedPreferences _preferences;
  bool _is24HourFormat;
  int _clockTheme;
  bool _showAmPm;

  void initSettings() {
    _is24HourFormat = _preferences.getBool(k24HourFormat) ?? true;
    _clockTheme = _preferences.getInt(kClockTheme) ?? 0;
    _showAmPm = _preferences.getBool(kShowAmPm) ?? false;
  }

  bool get is24HourFormat => _is24HourFormat;
  ClockTheme get clockTheme => ClockTheme.values[_clockTheme];
  bool get showAmPm => _showAmPm;

  set is24HourFormat(bool val) {
    if (val != _is24HourFormat) {
      _is24HourFormat = val;
      _preferences.setBool(k24HourFormat, val);
      notifyListeners();
    }
  }

  set clockTheme(ClockTheme theme) {
    if (theme.index != _clockTheme) {
      _clockTheme = theme.index;
      _preferences.setInt(kClockTheme, theme.index);
      notifyListeners();
    }
  }

  set showAmPm(bool val) {
    if (val != _showAmPm) {
      _showAmPm = val;
      _preferences.setBool(kShowAmPm, val);
      notifyListeners();
    }
  }
}

enum ClockTheme { dark, blue, orange, pink }
