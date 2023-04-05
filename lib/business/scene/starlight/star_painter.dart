import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/starlight/star.dart';

class StarPainter extends CustomPainter {
  StarPainter(this.stars);

  final List<Star> stars;

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      // 画星星的阴影
      canvas.drawCircle(
        star.offset,
        star.radius,
        star.shadowPaint,
      );

      // 画星星
      canvas.drawCircle(
        star.offset,
        star.radius,
        star.paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
