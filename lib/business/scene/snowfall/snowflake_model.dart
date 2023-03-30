import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowfall_point.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';
import 'package:supercharged/supercharged.dart';
import 'package:simple_animations/simple_animations.dart';

class SnowflakeModel {
  SnowflakeModel(this._random) {
    _restart();
  }

  static final Map<int, Path> _cachedFlakes = {};
  late MovieTween tween;
  late double _size;
  final Random _random;
  late Path? _path;
  late Duration _duration;
  late Duration _startTime;

  void _restart() {
    _path = null;
    final startPosition = Offset(-0.2 + 1.4 * _random.nextDouble(), -0.2);
    final endPosition = Offset(-0.2 + 1.4 * _random.nextDouble(), 1.2);

    _duration = Duration(seconds: 5, milliseconds: _random.nextInt(9999));
    _startTime = DateTime.now().duration();
    tween = MovieTween()
      ..scene(
              begin: _startTime,
              end: _startTime + _duration,
              curve: Curves.easeInOutSine)
          .tween("x", Tween(begin: startPosition.dx, end: endPosition.dx))
      ..scene(
              begin: _startTime,
              end: _startTime + _duration,
              curve: Curves.easeIn)
          .tween("y", Tween(begin: startPosition.dy, end: endPosition.dy));
    _size = 20 + _random.nextDouble() * 99;

    _drawPath();
  }

  void _drawPath() {
    if (_path != null) {
      return;
    }

    double sideLength = 99;
    int iterationsCount = 1; // 我们通过雪花的大小来计算迭代次数
    if (_size > 53) {
      iterationsCount += _size ~/ 25;
    }
    _path = Path();
    if (_cachedFlakes[iterationsCount] == null) {
      double down = (sideLength / 2) * tan(pi / 6);
      double up = (sideLength / 2) * tan(pi / 3) - down;
      SnowfallPoint p0 = SnowfallPoint(-sideLength / 2, down);
      SnowfallPoint p1 = SnowfallPoint(sideLength / 2, down);
      SnowfallPoint p2 = SnowfallPoint(0, -up);
      SnowfallPoint p3 = SnowfallPoint(0, 0);
      SnowfallPoint p4 = SnowfallPoint(0, 0);
      double rotate = _random.nextDouble() * pi * 2;
      List<SnowfallPoint> lines = <SnowfallPoint>[p0, p1, p2];
      List<SnowfallPoint> tempLines = <SnowfallPoint>[];
      for (int iterations = 0; iterations < iterationsCount; ++iterations) {
        sideLength /= 3;
        for (int loop = 0; loop < lines.length; ++loop) {
          p0 = lines[loop];
          if (loop == lines.length - 1) {
            p1 = lines[0];
          } else {
            p1 = lines[loop + 1];
          }
          rotate = atan2(p1.y - p0.y, p1.x - p0.x);
          p2 = p0 + SnowfallPoint.polarToPoint(sideLength, rotate);
          rotate += pi / 3;
          p3 = p2 + SnowfallPoint.polarToPoint(sideLength, rotate);
          rotate -= 2 * pi / 3;
          p4 = p3 + SnowfallPoint.polarToPoint(sideLength, rotate);
          tempLines.addAll([p0, p2, p3, p4]);
        }
        lines = tempLines;
        tempLines = <SnowfallPoint>[];
      }
      lines.add(p1);
      _path!.moveTo(lines[0].x, lines[0].y);
      for (int i = 0; i < lines.length; ++i) {
        _path!.lineTo(lines[i].x, lines[i].y);
      }
      _path!.lineTo(lines[0].x, lines[0].y);
      _cachedFlakes[iterationsCount] = _path!;
    } else {
      _path = _cachedFlakes[iterationsCount];
    }

    Matrix4 matrix = Matrix4.identity();
    matrix.setRotationZ(_random.nextDouble() * pi * 2);
    double scaleTo = _size / sideLength;
    matrix.scale(scaleTo);
    List<double> list = matrix.storage.toList();
    _path = _path?.transform(Float64List.fromList(list));
  }

  Path get path {
    if (_path != null) {
      return _path!;
    }

    _drawPath();
    return _path!;
  }

  double progress() {
    return ((DateTime.now().duration() - _startTime) / _duration)
        .clamp(0.0, 1.0)
        .toDouble();
  }

  void checkIfSnowflakeNeedsToBeRestarted() {
    if (progress() == 1.0) {
      _restart();
    }
  }
}
