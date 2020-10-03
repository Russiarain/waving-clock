import 'package:flutter/material.dart';
import 'package:waving_clock/settings.dart';
import 'package:intl/intl.dart';

class TimeLayer extends StatelessWidget {
  final DateTime _time;
  final Color _fontColor;
  final ClockSettings _settings;
  TimeLayer(this._time, this._settings, this._fontColor);
  String _getTimeString() {
    if (_settings.is24HourFormat) {
      return DateFormat(_settings.showTimeDelimiter ? 'HH:mm' : 'HH mm')
          .format(_time);
    } else {
      if (_settings.showAmPm) {
        return DateFormat(_settings.showTimeDelimiter ? 'hh:mm a' : 'hh mm a')
            .format(_time);
      } else {
        return DateFormat(_settings.showTimeDelimiter ? 'hh:mm' : 'hh mm')
            .format(_time);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final fontSize = 0.4 * height;
    return Positioned(
      top: 0.06 * height,
      bottom: 0.06 * height,
      left: 4,
      right: 4,
      child: Center(
        child: Text(_getTimeString(),
            style: TextStyle(fontSize: fontSize, color: _fontColor)),
      ),
    );
  }
}

class DateLayer extends StatelessWidget {
  final DateTime _time;
  final Color _fontColor;
  DateLayer(this._time, this._fontColor);
  String _getTimeString() {
    return DateFormat('EEEEEEEE , MMM d').format(_time);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final fontSize = 0.1 * height;
    return Positioned(
      bottom: 0.05 * height,
      left: 4,
      right: 4,
      child: Center(
        child: Text(_getTimeString(),
            style: TextStyle(fontSize: fontSize, color: _fontColor)),
      ),
    );
  }
}
