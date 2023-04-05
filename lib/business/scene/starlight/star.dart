import 'dart:math';

import 'package:flutter/material.dart';

class Star {
  late Paint paint; // 用于绘制星星
  late Paint shadowPaint; // 用于绘制星星的阴影
  late Offset offset; // 用于表示星星的位置
  late double radius; // 用于表示星星的半径
  late double _x, _y, _dx, _dy;
  late double _canvasWidth, _canvasHeight;

  static const double _maxRadius = 0.53 * 9;
  static const double _speedFactor = 0.53;

  Star(Size size) {
    Random random = Random();
    radius = random.nextDouble() * _maxRadius + 1;

    _canvasWidth = size.width;
    _canvasHeight = size.height;

    _x = random.nextDouble() * (_canvasWidth - radius * 2) + radius;
    _y = random.nextDouble() * (_canvasHeight - radius * 2) + radius;

    if (radius > 2) {
      _dx = (random.nextDouble() - _speedFactor) * 2;
      _dy = (random.nextDouble() - _speedFactor) * 2;
    } else {
      _dx = random.nextDouble() - _speedFactor;
      _dy = random.nextDouble() - _speedFactor;
    }

    offset = Offset(_x, _y);

    paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    shadowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        Shadow.convertRadiusToSigma(radius + 5.3),
      ); // 设置模糊效果
  }

  void update() {
    // 判断星星是否接触画布边缘，若接触则反转速度方向
    if (_x + radius > _canvasWidth || _x - radius < 0) {
      _dx = -_dx;
    }
    if (_y + radius > _canvasHeight || _y - radius < 0) {
      _dy = -_dy;
    }

    _x += _dx;
    _y += _dy;

    offset = Offset(_x, _y);
  }
}
