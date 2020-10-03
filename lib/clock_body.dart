import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waving_clock/components/background.dart';
import 'package:waving_clock/settings.dart';
import 'package:waving_clock/theme.dart';

import 'components/waves.dart';

class ClockBody extends StatefulWidget {
  final ClockSettings settings;
  ClockBody(this.settings);
  @override
  _ClockBodyState createState() => _ClockBodyState();
}

class _ClockBodyState extends State<ClockBody> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  bool _is24HourFormat;
  bool _showTimeDelimiter;
  bool _showAmPm;

  @override
  void initState() {
    super.initState();
    _is24HourFormat = widget.settings.is24HourFormat;
    _showTimeDelimiter = widget.settings.showTimeDelimiter;
    _showAmPm = widget.settings.showAmPm;

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
    _timer?.cancel();
    widget.settings.removeListener(_updateSettings);
    widget.settings.dispose();
    super.dispose();
  }

  void _updateSettings() {
    _is24HourFormat = widget.settings.is24HourFormat;
    _showTimeDelimiter = widget.settings.showTimeDelimiter;
    _showAmPm = widget.settings.showAmPm;
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
        Positioned.fill(child: AnimatedBackgroud(kThemeof[ClockTheme.blue])),
        waveLayer(waveHeight, 0, kThemeof[ClockTheme.blue].waveColor),
        waveLayer(waveHeight, 0.33 * pi, kThemeof[ClockTheme.blue].waveColor),
        waveLayer(waveHeight, 0.66 * pi, kThemeof[ClockTheme.blue].waveColor),
      ],
    );
  }
}
