import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowflake_model.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

class SnowflakesPainter extends CustomPainter {
  SnowflakesPainter(this.snowflakes);

  final List<SnowflakeModel> snowflakes;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = Colors.white.withAlpha(125)
      ..style = PaintingStyle.fill;

    for (var snowflake in snowflakes) {
      final progress = snowflake.progress();
      final Movie animation = snowflake.tween.transform(progress);
      final position =
          Offset(animation.get("x") * size.width, animation.get("y") * size.height);
      canvas.drawPath(snowflake.path.shift(position), p);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}