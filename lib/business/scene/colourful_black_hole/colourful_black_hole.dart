import 'dart:async';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/colourful_black_hole/colourful_black_hole_painter.dart';

/// https://twitter.com/creativemaybeno/status/1290173415530299392?s=20
/// Based on https://codegolf.tk/a/321.

/// [StatefulWidget] managing the animation for the custom painter.
class ColourfulBlackHole extends StatefulWidget {
  /// Constructs a `const` [ColourfulBlackHole].
  const ColourfulBlackHole({super.key});

  @override
  State<ColourfulBlackHole> createState() => _ColourfulBlackHoleState();
}

class _ColourfulBlackHoleState extends State<ColourfulBlackHole> {
  /// Notifies the animation about the currently elapsed time.
  late ValueNotifier<double> _time;

  /// Updates the [_time].
  late Timer _timer;

  /// Configurable attributes of the simulation.
  final int _particleCount = 253 * 2;
  final double _particleSize = 5.3 * 2;
  final double _blackHoleRadius = 5.3 * 2 * 2 * 2;
  final double _sprayRadius = 5.3 * 2 * 2;

  @override
  void initState() {
    super.initState();

    // Setup time.
    _time = ValueNotifier(0);
    // Setup timer.
    final begin = DateTime.now();
    _timer = Timer.periodic(
      const Duration(
        // Update up to 60 times a second.
        microseconds: 1e6 ~/ 60,
      ),
      (_) {
        _time.value = DateTime.now().difference(begin).inMicroseconds / 1e6;
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _time.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      willChange: true,
      painter: ColourfulBlackHolePainter(
        _time,
        particleCount: _particleCount,
        particleSize: _particleSize,
        blackHoleRadius: _blackHoleRadius,
        sprayRadius: _sprayRadius,
      ),
    );
  }
}
