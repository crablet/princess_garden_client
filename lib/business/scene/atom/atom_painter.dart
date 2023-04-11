import 'dart:math';

import 'package:flutter/material.dart';

class AtomPainter extends CustomPainter {
  final double progress;

  AtomPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.translate(size.width / 2, size.height / 2); // 将画布的坐标系原点平移到画布中心

    // 以下代码绘制自定义曲线：
    int numPoints = 999; // 表示曲线上的点数（这里为999个点）
    double scaleFactor = 99; // 表示曲线的缩放因子（这里为99）
    Path customCurvePath = Path();

    // 使用循环绘制曲线上的每个点，根据动画进度progress计算每个点的坐标（x, y）
    for (int i = 0; i < numPoints; i++) {
      double t = i * 2 * pi / numPoints + (2 * pi * progress); // 计算参数t，与动画进度相关
      double x = scaleFactor * cos(3 * t);
      double y = scaleFactor * sin(2 * t);
      // 这里使用的数学原理是极坐标系和参数方程：
      // r(t) = scaleFactor, x = r(t) * cos(3t), y = r(t) * sin(2t)
      // 当t在[0, 2pi]范围内变化时，这个函数绘制出类似原子结构的图形
      if (i == 0) {
        customCurvePath.moveTo(x, y); // 将曲线的起点设置为第一个点的坐标
      } else {
        customCurvePath.lineTo(x, y); // 将曲线的终点设置为当前点的坐标，并连接前一个点
      }
    }
    paint.color = Colors.blueAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawPath(customCurvePath, paint);

    // 以下代码绘制旋转线段：
    int numShapes = 9; // 表示要绘制的线段数量（这里为9）
    double angleStep = 2 * pi / numShapes; // 表示每个线段之间的角度差
    paint.strokeWidth = 3;

    // 使用循环绘制每个线段，根据动画进度progress计算线段的起点和终点
    for (int i = 0; i < numShapes; i++) {
      paint.color = Color.lerp(
        Colors.orange,
        Colors.yellow,
        i / (numShapes - 1),
      )!; // 设置画笔的颜色为橙色和黄色之间的插值
      double angle = i * angleStep + (2 * pi * progress); // 计算当前线段的角度，与动画进度相关
      double lineLength = 99; // 定义线段的长度（这里为99）

      // 计算线段的起点坐标（x1, y1）
      final p1 = Offset(
        cos(angle) * lineLength,
        sin(angle) * lineLength,
      );
      // 计算线段的终点坐标（x2, y2）
      final p2 = Offset(
        cos(angle + pi) * lineLength,
        sin(angle + pi) * lineLength,
      );
      canvas.drawLine(p1, p2, paint);
    }

    // 以下代码绘制沿着自定义曲线的动画圆：
    int numCurvePoints = 18; // 表示要绘制的圆的数量（这里为18）
    double circleRadius = 9; // 表示圆的半径（这里为9）
    paint.style = PaintingStyle.fill;

    // 使用循环绘制每个圆，根据动画进度progress计算圆的中心坐标（x, y）
    for (int i = 0; i < numCurvePoints; i++) {
      paint.color = Color.lerp(
        Colors.purple,
        Colors.green,
        i / (numCurvePoints - 1),
      )!; // 设置画笔的颜色为紫色和绿色之间的插值
      double t =
          i * 2 * pi / numCurvePoints + (2 * pi * progress); // 计算参数t，与动画进度相关
      double x = scaleFactor * cos(3 * t);
      double y = scaleFactor * sin(2 * t);
      canvas.drawCircle(Offset(x, y), circleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(AtomPainter oldDelegate) => true;
}
