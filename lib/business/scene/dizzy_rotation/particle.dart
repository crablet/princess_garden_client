import 'dart:ui';

class Particle {
  Particle({
    required this.size,
    required this.radius,
    required this.startingTheta,
    required this.colour,
  });

  double size;
  double radius;
  double startingTheta; // 粒子的射出角度
  Color colour;
}
