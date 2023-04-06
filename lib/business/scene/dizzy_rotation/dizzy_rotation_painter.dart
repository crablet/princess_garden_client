import 'dart:math';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/dizzy_rotation/particle.dart';

class DizzyRotationPainter extends CustomPainter {
  DizzyRotationPainter({
    required this.particles,
    required this.theta,
  });

  // 粒子列表
  final List<Particle> particles;

  // 当前旋转角度
  final double theta;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 5.3;

    for (final Particle particle in particles) {
      // 计算粒子当前的偏转角度，旋转是由于theta的改变而带来的
      final double randomTheta = particle.startingTheta + theta;
      final radius = particle.radius;
      // x = rcosθ，最后加的size.width / 2是为了在画布中央
      double dx = radius * theta * cos(randomTheta) + size.width / 2;
      // y = rsinθ，最后加的size.height / 2是为了在画布中央
      double dy = radius * theta * sin(randomTheta) + size.height / 2;

      final Offset position = Offset(dx, dy);
      paint.color = particle.colour;
      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
