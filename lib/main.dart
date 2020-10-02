import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clock.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waving Clock',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WavingClock(ClockSettings(snapshot.data)..initSettings());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
