import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waving_clock/theme.dart';

import 'clock.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<SharedPreferences> _getPreference() {
    return Future.delayed(Duration(milliseconds: 600))
        .then<SharedPreferences>((_) => SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waving Clock',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _getPreference(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WavingClock(ClockSettings(snapshot.data)..initSettings());
          }
          return Container(
              color: Colors.blueGrey[200],
              child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
