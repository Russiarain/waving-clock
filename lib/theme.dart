import 'package:flutter/material.dart';

enum ClockTheme { dark, blue, orange, pink }

final Map<ClockTheme, WavingTheme> kThemeof = {
  ClockTheme.blue: _buildBlueTheme()
};

class WavingTheme {
  final ColorTween backgroundTop;
  final ColorTween backgroudBottom;
  final Color waveColor;
  final Color fontColor;

  WavingTheme(
      {this.backgroundTop,
      this.backgroudBottom,
      this.waveColor,
      this.fontColor});
}

WavingTheme _buildBlueTheme() {
  return WavingTheme(
      backgroundTop:
          ColorTween(begin: Color(0xff69f0ae), end: Color(0xff18ffff)),
      backgroudBottom:
          ColorTween(begin: Color(0xff18ffff), end: Color(0xff69f0ae)),
      waveColor: Colors.white30.withAlpha(48),
      fontColor: Colors.black38);
}
