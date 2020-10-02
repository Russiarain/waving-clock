import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wakelock/wakelock.dart';
import 'package:waving_clock/settings.dart';

class WavingClock extends StatefulWidget {
  final ClockSettings _settings;
  WavingClock(this._settings);
  @override
  _WavingClockState createState() => _WavingClockState();
}

class _WavingClockState extends State<WavingClock> {
  @override
  void initState() {
    super.initState();
    widget._settings.addListener(_handleSettingsChange);
    Wakelock.enable();
  }

  @override
  void dispose() {
    widget._settings.removeListener(_handleSettingsChange);
    widget._settings.dispose();
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
                  value: widget._settings.is24HourFormat,
                  onChanged: (val) {
                    widget._settings.is24HourFormat = val;
                  }),
            ),
            ListTile(
              title: Text('Theme'),
              trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<ClockTheme>(
                      value: widget._settings.clockTheme,
                      isDense: true,
                      items: ClockTheme.values
                          .map((e) => DropdownMenuItem<ClockTheme>(
                              value: e, child: Text(getEnumSubString(e))))
                          .toList(),
                      onChanged: (theme) {
                        widget._settings.clockTheme = theme;
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

    return Scaffold(
      body: Center(
        child: Text('Body'),
      ),
      endDrawer: _buildDrader(context),
    );
  }
}

String getEnumSubString(Object e) => e.toString().split('.').last;
