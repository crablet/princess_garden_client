import 'dart:math' as math;

import 'package:flutter/material.dart';

class SierpinskiTriangleFactory extends ChangeNotifier {
  final List<Path> paths = [];
  static const double kSize = 53 * 2;

  SierpinskiTriangleFactory() {
    _start(kSize, paths);
  }

  void _start(double sz, List<Path> paths) {
    paths.clear();

    final midPoint = Offset(sz / 2, sz / 2);
    const iterations = 6;
    final rInner = sz / 6 * math.sqrt(3);
    final rOuter = sz / 3 * math.sqrt(3);

    final pointA = Offset(midPoint.dx - sz / 2, midPoint.dy + rInner);
    final pointB = Offset(midPoint.dx + sz / 2, midPoint.dy + rInner);
    final pointC = Offset(midPoint.dx, midPoint.dy - rOuter);
    _sierpinski(pointA, pointB, pointC, iterations);
  }

  void _sierpinski(Offset pointA, Offset pointB, Offset pointC, int d) async {
    if (d > 0) {
      final pointAx = (pointB.dx + pointC.dx) / 2;
      final pointAy = (pointB.dy + pointC.dy) / 2;

      final pointBx = (pointA.dx + pointC.dx) / 2;
      final pointBy = (pointA.dy + pointC.dy) / 2;

      final pointCx = (pointA.dx + pointB.dx) / 2;
      final pointCy = (pointA.dy + pointB.dy) / 2;

      final a = Offset(pointAx, pointAy);
      final b = Offset(pointBx, pointBy);
      final c = Offset(pointCx, pointCy);

      final d2 = d - 1;
      await Future.delayed(Duration(milliseconds: d2 * 100));
      _sierpinski(pointA, b, c, d2);
      await Future.delayed(Duration(milliseconds: d2 * 200));
      _sierpinski(c, a, pointB, d2);
      await Future.delayed(Duration(milliseconds: d2 * 300));
      _sierpinski(b, a, pointC, d2);
    } else {
      final path = Path()
        ..moveTo(pointA.dx, pointA.dy)
        ..lineTo(pointB.dx, pointB.dy)
        ..lineTo(pointC.dx, pointC.dy)
        ..lineTo(pointA.dx, pointA.dy);
      paths.add(path);
      notifyListeners();
    }
  }
}
