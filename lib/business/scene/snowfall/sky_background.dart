import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

class SkyBackground extends StatelessWidget {
  const SkyBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..scene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 5253),
      ).tween(
          "color0",
          ColorTween(
            begin: Colors.blue.shade600,
            end: Colors.lightBlue.shade900,
          ))
      ..scene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 5253),
      ).tween(
          "color1",
          ColorTween(
            begin: Colors.lightBlue.shade900,
            end: Colors.blue.shade600,
          ));

    return MirrorAnimationBuilder(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                value.get("color0"),
                value.get("color1"),
              ],
            ),
          ),
        );
      },
      tween: tween,
      duration: const Duration(seconds: 3),
    );
  }
}
