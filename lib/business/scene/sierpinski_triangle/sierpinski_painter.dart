import 'package:flutter/material.dart';

class SierpinskiPainter extends CustomPainter {
  static const double kSize = 53 * 2;
  final List<Path> paths;
  final trianglePaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 0.53
    ..style = PaintingStyle.stroke;

  SierpinskiPainter(this.paths);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height / 10);
    final scale = size.shortestSide / kSize;
    canvas.scale(scale);
    for (final path in paths) {
      canvas.drawPath(path, trianglePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
