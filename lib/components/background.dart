import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:waving_clock/theme.dart';

class AnimatedBackgroud extends StatelessWidget {
  final WavingTheme theme;

  AnimatedBackgroud(this.theme);

  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AnimateProps>()
      ..add(AnimateProps.topColor, theme.backgroundTop, 3.seconds)
      ..add(AnimateProps.bottomColor, theme.backgroudBottom, 3.seconds);

    return MirrorAnimation(
      key: ObjectKey(theme),
      tween: _tween,
      duration: _tween.duration, //max duration of all tweens
      builder: (context, _, MultiTweenValues<AnimateProps> values) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                values.get(AnimateProps.topColor),
                values.get(AnimateProps.bottomColor)
              ])),
        );
      },
    );
  }
}

enum AnimateProps { topColor, bottomColor }
