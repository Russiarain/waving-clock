import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';
import 'clock.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize device orientation with landscape left
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return MaterialApp(
      title: 'Waving Clock',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WavingClock(ClockSettings(snapshot.data!)..initSettings());
          }
          return Container(
            color: Colors.blueGrey[200],
          );
        },
      ),
    );
  }
}
