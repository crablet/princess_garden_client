import 'dart:async';
import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/game_of_life/game_of_life_painter.dart';

const double height = 53 * 20, width = 53 * 20;

class GameOfLife extends StatefulWidget {
  const GameOfLife({super.key});

  @override
  State<StatefulWidget> createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  late Timer timer;
  GameOfLifePainter painter = GameOfLifePainter(width, height);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 53 * 2), (Timer t) {
      setState(() {
        painter.update();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            key: ValueKey(timer.tick),
            painter: painter,
          ),
        ),
      ),
    );
  }
}
