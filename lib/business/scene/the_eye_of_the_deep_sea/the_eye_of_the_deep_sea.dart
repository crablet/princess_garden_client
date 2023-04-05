import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/the_eye_of_the_deep_sea/spin_painter.dart';
import 'package:princess_garden_client/business/scene/the_eye_of_the_deep_sea/spin_rect.dart';

class TheEyeOfDeepSea extends StatefulWidget {
  const TheEyeOfDeepSea({
    Key? key,
  }) : super(key: key);

  @override
  State<TheEyeOfDeepSea> createState() => _TheEyeOfDeepSeaState();
}

class _TheEyeOfDeepSeaState extends State<TheEyeOfDeepSea>
    with SingleTickerProviderStateMixin {
  final List<SpinRect> _rectList = [
    SpinRect(colour: const Color(0xFFDB4437), begin: 0.0, end: 0.99),
    SpinRect(colour: const Color(0xFFF4B400), begin: 0.253, end: 1.253),
    SpinRect(colour: const Color(0xFF4285F4), begin: 0.53, end: 1.53),
    SpinRect(colour: const Color(0xFF0F9D58), begin: 0.78, end: 1.78),
  ];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5300),
    )
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: 253,
          height: 253,
          child: CustomPaint(
            painter: SpinPainter(
              blendMode: BlendMode.screen,
              rectList: _rectList,
              animation: _controller,
            ),
          ),
        ),
      ),
    );
  }
}
