import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class RequiemTransition extends StatelessWidget {
  const RequiemTransition(
      {Key? key, required this.sceneDuration, required this.transitionDuration})
      : super(key: key);

  final Duration sceneDuration;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    final MovieTween tween = MovieTween()
      ..scene(begin: Duration.zero, end: sceneDuration)
          .tween("opacity", Tween(begin: 0.0, end: 0.0))
      ..scene(begin: sceneDuration, end: sceneDuration + transitionDuration)
          .tween("opacity", Tween(begin: 0.0, end: 1.0))
      ..scene(
              begin: sceneDuration + transitionDuration,
              end: sceneDuration +
                  transitionDuration +
                  const Duration(seconds: 2))
          .tween("opacity", Tween(begin: 1.0, end: 1.0))
      ..scene(
              begin: sceneDuration +
                  transitionDuration +
                  const Duration(seconds: 2),
              end: sceneDuration +
                  transitionDuration +
                  const Duration(seconds: 2, milliseconds: 253))
          .tween("opacity", Tween(begin: 1.0, end: 0.0));

    return Positioned.fill(
      child: PlayAnimationBuilder<Movie>(
        tween: tween,
        duration: tween.duration,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.get("opacity"),
            child: Container(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
