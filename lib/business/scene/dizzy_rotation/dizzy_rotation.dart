import 'dart:math';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/dizzy_rotation/dizzy_rotation_painter.dart';
import 'package:princess_garden_client/business/scene/dizzy_rotation/particle.dart';

class DizzyRotation extends StatefulWidget {
  const DizzyRotation({Key? key}) : super(key: key);

  @override
  State<DizzyRotation> createState() => _DizzyRotationState();
}

class _DizzyRotationState extends State<DizzyRotation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  // 粒子列表
  final List<Particle> _particles = [];

  static const int numberOfParticles = 999;

  void generateListOfParticles() {
    for (int i = 0; i < numberOfParticles; ++i) {
      final Random random = Random();
      final int r = random.nextInt(256);
      final int g = random.nextInt(256);
      final int b = random.nextInt(256);
      final Color colour = Color.fromARGB(255, r, g, b);
      final double size = random.nextDouble() * 18;
      final double radius = random.nextDouble() * 199;
      final double theta = random.nextDouble() * 2 * pi;
      final Particle particle = Particle(
        size: size,
        radius: radius,
        startingTheta: theta,
        colour: colour,
      );
      _particles.add(particle);
    }
  }

  @override
  void initState() {
    super.initState();

    generateListOfParticles();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5300),
    );

    // 定义旋转动画
    Tween<double> rotationTween = Tween(begin: 0, end: 2 * pi);

    // 关联动画和控制器
    _animation = rotationTween.animate(_controller)
      ..addListener(() {
        // 监听动画值的变化并更新 UI
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    // 开始播放动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DizzyRotationPainter(
        particles: _particles,
        theta: _animation.value,
      ),
    );
  }
}
