import 'package:flutter/material.dart';

enum ClockTheme { dark, teal, orange, blue }

final Map<ClockTheme, WavingTheme> kThemeof = {
  ClockTheme.teal: _buildTealTheme(),
  ClockTheme.dark: _buildDarkTheme(),
  ClockTheme.orange: _buildOrangeTheme(),
  ClockTheme.blue: _buildBlueTheme()
};

class WavingTheme {
  final ColorTween backgroundTop;
  final ColorTween backgroudBottom;
  final Color waveColor;
  final Color fontColor;

  WavingTheme(
      {required this.backgroundTop,
      required this.backgroudBottom,
      required this.waveColor,
      required this.fontColor});
}

WavingTheme _buildTealTheme() {
  return WavingTheme(
      backgroundTop:
          ColorTween(begin: Color(0xff69f0ae), end: Color(0xff18ffff)),
      backgroudBottom:
          ColorTween(begin: Color(0xff18ffff), end: Color(0xff69f0ae)),
      waveColor: Colors.white30.withAlpha(48),
      fontColor: Colors.black38);
}

WavingTheme _buildOrangeTheme() {
  return WavingTheme(
      backgroundTop:
          ColorTween(begin: Color(0xfff44336), end: Color(0xffff5722)),
      backgroudBottom:
          ColorTween(begin: Colors.amber[700], end: Colors.orange[700]),
      waveColor: Colors.white.withAlpha(48),
      fontColor: Colors.white60);
}

WavingTheme _buildDarkTheme() {
  return WavingTheme(
      backgroundTop:
          ColorTween(begin: Color(0xff37474f), end: Color(0xff212121)),
      backgroudBottom:
          ColorTween(begin: Color(0xff212121), end: Color(0xff37474f)),
      waveColor: Color(0xFF546E7A).withAlpha(48),
      fontColor: Colors.white54);
}

WavingTheme _buildBlueTheme() {
  return WavingTheme(
      backgroundTop:
          ColorTween(begin: Color(0xff18ffff), end: Color(0xff006ecb)),
      backgroudBottom:
          ColorTween(begin: Color(0xffaa00ff), end: Color(0xff18ffff)),
      waveColor: Color(0x806cccff),
      fontColor: Colors.white60);
}

final lightTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.black54),
  splashColor: Colors.deepPurpleAccent[700],
  fontFamily: 'Lato',
);
