import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
  DeviceOrientation _deviceOrientation = DeviceOrientation.landscapeLeft;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              title: Text(
                '24 Hour Format',
                //style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Checkbox(
                  value: widget._settings.is24HourFormat,
                  onChanged: (val) {
                    widget._settings.is24HourFormat = val!;
                  }),
            ),
            ListTile(
              enabled: !widget._settings.is24HourFormat,
              title: Text(
                'Show AM/PM',
                //style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Checkbox(
                  value: widget._settings.showAmPm,
                  onChanged: widget._settings.is24HourFormat ||
                          _deviceOrientation == DeviceOrientation.portraitUp
                      ? null
                      : (val) => widget._settings.showAmPm = val!),
            ),
            ListTile(
                title: Text(
                  'Show time delimiter',
                  //style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Checkbox(
                  value: widget._settings.showTimeDelimiter,
                  onChanged: _deviceOrientation == DeviceOrientation.portraitUp
                      ? null
                      : (value) => widget._settings.showTimeDelimiter = value!,
                )),
            ListTile(
              title: Text(
                'Theme',
                //style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<ClockTheme>(
                      value: widget._settings.clockTheme,
                      isDense: true,
                      items: ClockTheme.values
                          .map((e) => DropdownMenuItem<ClockTheme>(
                              value: e,
                              child: Text(
                                getEnumSubString(e),
                                style: Theme.of(context).textTheme.bodyText1,
                              )))
                          .toList(),
                      onChanged: (theme) {
                        widget._settings.clockTheme = theme!;
                      })),
            ),
            ListTile(
              title: Text('View source code'),
              trailing: Icon(Icons.open_in_new_rounded),
              onTap: () async {
                final url = 'https://github.com/Russiarain/waving-clock';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print('Link to Github failed');
                }
              },
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildButtonLayer(double btnSize) {
    var quitBtn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.power_settings_new_rounded),
          iconSize: btnSize,
          splashRadius: btnSize,
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
        Text(
          'Quit',
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
    var settingsBtn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.settings),
          iconSize: btnSize,
          splashRadius: btnSize,
          onPressed: () {
            _scaffoldKey.currentState!.openEndDrawer();
            setState(() => _showButtons = false);
          },
        ),
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
    void handleOrientationChange(DeviceOrientation deviceOrientation) {
      SystemChrome.setPreferredOrientations([deviceOrientation]);
      setState(() {
        _deviceOrientation = deviceOrientation;
        _showButtons = false;
      });
    }

    return Material(
      color: Colors.transparent,
      child: OrientationBuilder(builder: (_, orientation) {
        if (orientation == Orientation.landscape) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                quitBtn,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(Icons.upload_rounded),
                        iconSize: btnSize * 0.8,
                        onPressed: () {
                          if (_deviceOrientation ==
                              DeviceOrientation.landscapeLeft) {
                            handleOrientationChange(
                                DeviceOrientation.landscapeRight);
                          } else {
                            handleOrientationChange(
                                DeviceOrientation.landscapeLeft);
                          }
                        }),
                    IconButton(
                        icon: Icon(Icons.crop_portrait_rounded),
                        iconSize: btnSize * 0.8,
                        onPressed: () {
                          handleOrientationChange(DeviceOrientation.portraitUp);
                        })
                  ],
                ),
                settingsBtn
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                quitBtn,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(Icons.rotate_left_rounded),
                        iconSize: btnSize * 0.8,
                        onPressed: () {
                          handleOrientationChange(
                              DeviceOrientation.landscapeLeft);
                        }),
                    IconButton(
                        icon: Icon(Icons.rotate_right_rounded),
                        iconSize: btnSize * 0.8,
                        onPressed: () {
                          handleOrientationChange(
                              DeviceOrientation.landscapeRight);
                        })
                  ],
                ),
                settingsBtn
              ],
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // hide status bar and bottom bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    var btnSize = 0.0;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      btnSize = MediaQuery.of(context).size.height / 3;
    } else {
      btnSize = MediaQuery.of(context).size.width / 3;
    }

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showButtons = !_showButtons;
          });
        },
        child: Stack(children: [
          ClockBody(widget._settings),
          if (_showButtons)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4,
                  sigmaY: 4,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          if (_showButtons) _buildButtonLayer(btnSize),
        ]),
      ),
      endDrawer: _buildDrader(context),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}

String getEnumSubString(Object e) => e.toString().split('.').last;
