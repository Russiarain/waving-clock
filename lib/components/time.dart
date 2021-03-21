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

  String _getVerticalTimeString() =>
      DateFormat(_is24HourFormat ? 'HH\nmm' : 'hh\nmm').format(_time);

  String _getDateString() => DateFormat('EEEEEEEE , MMM d').format(_time);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Positioned.fill(
        child: OrientationBuilder(
            builder: (context, orientation) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Center(
                          child: Text(
                            orientation == Orientation.landscape
                                ? _getTimeString()
                                : _getVerticalTimeString(),
                            style: TextStyle(
                                color: _fontColor,
                                fontSize: orientation == Orientation.landscape
                                    ? screenHeight * 0.8 * 0.5
                                    : screenHeight * 0.8 * 0.3),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            _getDateString(),
                            style: TextStyle(
                                color: _fontColor,
                                fontSize: orientation == Orientation.landscape
                                    ? screenHeight * 0.2 * 0.7
                                    : screenHeight * 0.2 * 0.2),
                          ),
                        ))
                  ],
                )));
  }
}
