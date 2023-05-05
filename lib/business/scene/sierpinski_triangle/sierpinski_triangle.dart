import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/sierpinski_triangle/sierpinski_painter.dart';
import 'package:princess_garden_client/business/scene/sierpinski_triangle/sierpinski_triangle_factory.dart';

const double kSize = 53 * 2;

class SierpinskiTriangle extends StatefulWidget {
  const SierpinskiTriangle({super.key});

  @override
  State<SierpinskiTriangle> createState() => _SierpinskiTriangleState();
}

class _SierpinskiTriangleState extends State<SierpinskiTriangle> {
  late SierpinskiTriangleFactory simulation;

  @override
  void initState() {
    super.initState();
    simulation = SierpinskiTriangleFactory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: AnimatedBuilder(
        animation: simulation,
        builder: (context, _) => Center(
          child: CustomPaint(
            painter: SierpinskiPainter(simulation.paths),
            child: SizedBox(
              height: MediaQuery.of(context).size.shortestSide,
              width: MediaQuery.of(context).size.shortestSide,
            ),
          ),
        ),
      ),
    );
  }
}
