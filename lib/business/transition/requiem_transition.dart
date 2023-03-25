import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';
import 'package:simple_animations/simple_animations.dart';

class RequiemTransition extends StatelessWidget {
  const RequiemTransition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieTween tween = MovieTween()
      ..scene(
              begin: const Duration(milliseconds: 0),
              end: const Duration(milliseconds: 5253))
          .tween("opacity", Tween(begin: 0.0, end: 1.0))
      ..scene(
              begin: const Duration(milliseconds: 5253),
              end: const Duration(seconds: 2, milliseconds: 5253))
          .tween("opacity", Tween(begin: 1.0, end: 1.0))
      ..scene(
              begin: const Duration(seconds: 2, milliseconds: 5253),
              end: const Duration(seconds: 2, milliseconds: 5253 + 253))
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
