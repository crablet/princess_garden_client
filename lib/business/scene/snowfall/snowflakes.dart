import 'dart:math';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowflake_model.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowflakes_painter.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';

class Snowflakes extends StatefulWidget {
  const Snowflakes({Key? key, this.numberOfSnowflakes = 53}) : super(key: key);

  final int numberOfSnowflakes;

  @override
  State<Snowflakes> createState() => _SnowflakesState();
}

class _SnowflakesState extends State<Snowflakes> {
  final Random _random = Random();
  final List<SnowflakeModel> flakes = [];

  @override
  void initState() {
    List.generate(
      widget.numberOfSnowflakes,
      (index) => flakes.add(SnowflakeModel(_random)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: ConstantTween(1),
      builder: (_, __, ___) {
        _simulateFlakes();
        return CustomPaint(
          painter: SnowflakesPainter(flakes),
        );
      },
    );
  }

  void _simulateFlakes() {
    for (var flake in flakes) {
      flake.checkIfSnowflakeNeedsToBeRestarted();
    }
  }
}
