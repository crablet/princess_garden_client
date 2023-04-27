import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// [CustomPainter] that takes care of actually painting the animation.
class ColourfulBlackHolePainter extends CustomPainter {
  /// Constructs a [ColourfulBlackHolePainter] given an [time].
  ColourfulBlackHolePainter(
    this.time, {
    required this.particleCount,
    required this.blackHoleRadius,
    required this.sprayRadius,
    required this.particleSize,
  }) : super(repaint: time);

  /// Time that controls how the animation is drawn.
  ///
  /// The value of this animation should be `t` in seconds.
  final ValueListenable<double> time;

  /// The number of particles that fly around and will be created after the
  /// previous particles reach the destination each time.
  final int particleCount;

  /// How close the particles need to be to the destination in order to reach it.
  final double blackHoleRadius;

  /// How many pixels the particles should be sprayed out around the creation
  /// point initially.
  final double sprayRadius;

  /// Size for each particle.
  ///
  /// The width and height of each particle drawn is equal to this size value.
  final double particleSize;

  /// Padding controlling the minimum distance any destination for the particles
  /// can be away from any edge of the available space.
  static const _destinationPadding = 124;

  /// Position of the particles.
  double _x = 0, _y = 0;

  /// All information about all particles.
  /// _particles[i][0]: 粒子在x轴上的位置。
  /// _particles[i][1]: 粒子在y轴上的位置。
  /// _particles[i][2]: 粒子在x轴上的速度（水平方向）。
  /// _particles[i][3]: 粒子在y轴上的速度（垂直方向）。
  /// _particles[i][4]: 粒子与目标之间的距离。
  List<List<double>> _particles = [];

  /// Creates a fresh bunch of particles that will decay over time (until
  /// they reach the destination).
  void _createParticles(Size size) {
    // Random that will be used to create the particles.
    final random = Random();

    // Start without any particles.
    _particles = [];

    // Create the particles.
    for (int i = 0; i < particleCount; ++i) {
      // The angle of this particle.
      // Each particle is distributed in a circle around the creation point.
      // In total, the particles fill up all angles in _particleCount steps.
      final angle = pi * 2 / particleCount * i;

      // Add a particle at the current position and random initial values.
      _particles.add([
        _x,
        _y,
        sin(angle) * sprayRadius * random.nextDouble(),
        cos(angle) * sprayRadius * random.nextDouble(),
        0,
      ]);
    }

    // Select a random destination for the particles in the available space.
    // The destination is padded to avoid particles flying off screen.
    _x = _destinationPadding +
        random.nextDouble() * (size.width - _destinationPadding * 2);
    _y = _destinationPadding +
        random.nextDouble() * (size.height - _destinationPadding * 2);
  }

  /// Calculates the hypotenuse of a triangle with side lengths [v1] and [v2].
  ///
  /// This means that the square root of the sum of squares of [v1] and [v2] is
  /// returned from this function.
  double _hypot(double v1, double v2) {
    return sqrt(pow(v1, 2) + pow(v2, 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Time in seconds.
    final t = time.value;

    // Create particles initially and when all particles have reached the
    // destination.
    if (_particles.isEmpty != false) {
      _createParticles(size);
    }

    // Draw background.
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color =
            // Dart dark blue with low alpha for streaks.
            const Color.fromARGB(255, 18, 32, 47),
    );

    // Draw all particles and advance them.
    for (final particle in _particles) {
      // Set the distance of this particle to the destination.
      particle[4] = _hypot(_x - particle[0], _y - particle[1]);

      // Advance this particle and paint it.

      // Update spread.
      final c = pow(particle[4], 2) / 250;
      particle[2] += (_x - particle[0]) / c;
      particle[3] += (_y - particle[1]) / c;

      // Derive the color from HSL.
      final color = HSLColor.fromAHSL(
        1,
        (t * 4e2 - _hypot(particle[2], particle[3]) * 29) % 360,
        .8,
        .85,
      ).toColor();

      // Advance in the x direction.
      particle[2] *= .97;
      particle[0] += particle[2];

      // Advance in the y direction.
      particle[3] *= .97;
      particle[1] += particle[3];

      // Draw the particle.
      canvas.drawOval(
        Rect.fromLTWH(
          particle[0],
          particle[1],
          particleSize,
          particleSize,
        ),
        Paint()..color = color,
      );
    }

    // Remove particles that have reached the destination.
    _particles.removeWhere((particle) {
      return particle[4] < blackHoleRadius;
    });
  }

  // Repaints should only be triggered by the time.
  // Whether this is true or false does not matter at all.
  @override
  bool shouldRepaint(oldDelegate) => false;
}
