import 'package:flutter/material.dart';

import 'package:princess_garden_client/business/scene/atom/atom_painter.dart';

class Atom extends StatefulWidget {
  const Atom({super.key});

  @override
  State<Atom> createState() => _AtomState();
}

class _AtomState extends State<Atom> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 5300 * 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: AtomPainter(_animationController.value),
          child: Container(),
        );
      },
    );
  }
}
