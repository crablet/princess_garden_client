import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/starlight/star.dart';
import 'package:princess_garden_client/business/scene/starlight/star_painter.dart';

class StarLight extends StatefulWidget {
  const StarLight({Key? key}) : super(key: key);

  @override
  State<StarLight> createState() => _StarLightState();
}

class _StarLightState extends State<StarLight> {
  late Size _size;
  final List<Star> _stars = [];
  static const int _maxStar = 53;

  @override
  void didChangeDependencies() {
    _size = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    _stars.clear();
    for (int i = 0; i < _maxStar; ++i) {
      _stars.add(Star(_size));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      setState(() {
        for (final star in _stars) {
          star.update();
        }
      });
    });

    return Container(
      color: Colors.black,
      child: CustomPaint(
        size: _size,
        painter: StarPainter(_stars),
      ),
    );
  }
}
