import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLayer extends StatelessWidget {
  final DateTime _time;
  final Color _fontColor;
  final bool _showTimeDelimiter;
  final bool _is24HourFormat;
  final bool _showAmPm;
  TimeLayer(this._time, this._fontColor, this._showTimeDelimiter,
      this._is24HourFormat, this._showAmPm);
  String _getTimeString() {
    if (_is24HourFormat) {
      return DateFormat(_showTimeDelimiter ? 'HH:mm' : 'HH mm').format(_time);
    } else {
      if (_showAmPm) {
        return DateFormat(_showTimeDelimiter ? 'hh:mm a' : 'hh mm a')
            .format(_time);
      } else {
        return DateFormat(_showTimeDelimiter ? 'hh:mm' : 'hh mm').format(_time);
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
            style: TextStyle(
              fontSize: fontSize,
              color: _fontColor,
            )),
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
            style: TextStyle(
              fontSize: fontSize,
              color: _fontColor,
            )),
      ),
    );
  }
}
