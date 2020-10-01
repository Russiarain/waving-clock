import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ClockSettings _settings = ClockSettings()..initSettings();

  @override
  void initState() {
    super.initState();
    _settings.addListener(_handleSettingsChange);
    Wakelock.enable();
  }

  @override
  void dispose() {
    _settings.removeListener(_handleSettingsChange);
    _settings.dispose();
    super.dispose();
  }

  void _handleSettingsChange() => setState(() {});

  Widget _buildDrader(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Settings'),
            ),
            ListTile(
              title: Text('24 Hour Format'),
              trailing: Switch(
                  value: _settings.is24HourFormat,
                  onChanged: (val) {
                    _settings.is24HourFormat = val;
                  }),
            ),
            ListTile(
              title: Text('Theme'),
              trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<ClockTheme>(
                      value: _settings.clockTheme,
                      isDense: true,
                      items: ClockTheme.values
                          .map((e) => DropdownMenuItem<ClockTheme>(
                              value: e, child: Text(getEnumSubString(e))))
                          .toList(),
                      onChanged: (theme) {
                        _settings.clockTheme = theme;
                      })),
            )
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // app only works in landscape mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    // hide status bar and bottom bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Waving Clock',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Body'),
        ),
        endDrawer: _buildDrader(context),
      ),
    );
  }
}

String getEnumSubString(Object e) => e.toString().split('.').last;
