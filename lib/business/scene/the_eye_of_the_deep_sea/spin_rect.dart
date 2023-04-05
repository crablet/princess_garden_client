import 'package:flutter/animation.dart';

class SpinRect {
  SpinRect({
    required this.colour,
    required double begin,
    required double end,
  }) : tween = Tween<double>(begin: begin, end: end);

  final Color colour;
  final double strokeWidth = 5.3 * 2;
  final Tween<double> tween;
}
