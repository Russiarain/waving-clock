import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/time.dart';
import 'components/waves.dart';
import 'settings.dart';
import 'theme.dart';

class ClockBody extends StatefulWidget {
  final ClockSettings settings;
  ClockBody(this.settings);
  @override
  _ClockBodyState createState() => _ClockBodyState();
}

class _ClockBodyState extends State<ClockBody> {
  DateTime _dateTime = DateTime.now();
  late Timer _timer;

  late bool _is24HourFormat;
  late bool _showTimeDelimiter;
  late bool _showAmPm;
  late ClockTheme _theme;

  @override
  void initState() {
    super.initState();
    _is24HourFormat = widget.settings.is24HourFormat;
    _showTimeDelimiter = widget.settings.showTimeDelimiter;
    _showAmPm = widget.settings.showAmPm;
    _theme = widget.settings.clockTheme;

    widget.settings.addListener(_updateSettings);
    _updateTime();
  }

  @override
  void didUpdateWidget(covariant ClockBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.settings != oldWidget.settings) {
      oldWidget.settings.removeListener(_updateSettings);
      widget.settings.addListener(_updateSettings);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.settings.removeListener(_updateSettings);
    widget.settings.dispose();
    super.dispose();
  }

  void _updateSettings() {
    _is24HourFormat = widget.settings.is24HourFormat;
    _showTimeDelimiter = widget.settings.showTimeDelimiter;
    _showAmPm = widget.settings.showAmPm;
    _theme = widget.settings.clockTheme;
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final waveHeight =
        (screenSize.width * _dateTime.second / 59).floorToDouble();
    return Stack(
      children: [
        Positioned.fill(child: AnimatedBackgroud(kThemeof[_theme]!)),
        waveLayer(waveHeight, 0, kThemeof[_theme]!.waveColor),
        waveLayer(waveHeight, 0.33 * pi, kThemeof[_theme]!.waveColor),
        waveLayer(waveHeight, 0.66 * pi, kThemeof[_theme]!.waveColor),
        TimeLayer(_dateTime, kThemeof[_theme]!.fontColor, _showTimeDelimiter,
            _is24HourFormat, _showAmPm),
      ],
    );
  }
}
