import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wakelock/wakelock.dart';

import 'clock_body.dart';
import 'settings.dart';
import 'theme.dart';

class WavingClock extends StatefulWidget {
  final ClockSettings _settings;
  WavingClock(this._settings);
  @override
  _WavingClockState createState() => _WavingClockState();
}

class _WavingClockState extends State<WavingClock> {
  bool _showButtons = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
              trailing: Checkbox(
                  value: widget._settings.is24HourFormat,
                  onChanged: (val) {
                    widget._settings.is24HourFormat = val;
                  }),
            ),
            ListTile(
              enabled: !widget._settings.is24HourFormat,
              title: Text('Show AM/PM'),
              trailing: Checkbox(
                  value: widget._settings.showAmPm,
                  onChanged: widget._settings.is24HourFormat
                      ? null
                      : (val) => widget._settings.showAmPm = val),
            ),
            ListTile(
              title: Text('Show time delimiter'),
              trailing: Checkbox(
                value: widget._settings.showTimeDelimiter,
                onChanged: (value) =>
                    widget._settings.showTimeDelimiter = value,
              ),
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
      key: _scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showButtons = !_showButtons;
            });
          },
          child: Stack(children: [
            ClockBody(widget._settings),
            Visibility(
              visible: _showButtons,
              child: Positioned(
                  top: 4,
                  left: 4,
                  child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Exit Waving Clock ?'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                              label: 'Yes',
                              onPressed: () {
                                SystemNavigator.pop();
                                //print('Quit app');
                              }),
                        ));
                      })),
            ),
            Visibility(
                visible: _showButtons,
                child: Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                        icon: Icon(
                          Icons.chevron_left_outlined,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openEndDrawer();
                          setState(() => _showButtons = false);
                        })))
          ]),
        ),
      ),
      endDrawer: _buildDrader(context),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}

String getEnumSubString(Object e) => e.toString().split('.').last;
