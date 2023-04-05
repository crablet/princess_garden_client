import 'dart:math';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/the_eye_of_the_deep_sea/spin_rect.dart';

class SpinPainter extends CustomPainter {
  SpinPainter({
    required this.blendMode,
    required this.animation,
    required this.rectList,
  }) : super(repaint: animation);

  final List<SpinRect> rectList;

  // We accept the animation for two reasons: first, it drives when the custom
  // painter should repaint. Second, it allows us to get the current value of
  // the animation so we can use that to calculate the current rotation of each
  // SpinRect.
  final Animation<double> animation;
  final BlendMode blendMode;

  Size? _cachedSize;
  late RRect _cachedFunkyRect;

  @override
  void paint(Canvas canvas, Size size) {
    // Create a separate layer for the canvas, so the rectangles will not be
    // composited onto the background color.
    canvas.saveLayer(null, Paint());

    // Defines the Rect we'll be drawing and it's funky border radii
    final funkyRect = _buildFunkyRect(size);

    // The drawing portion of the class. It is responsible for drawing all of
    // the different rectangles.
    for (final rect in rectList) {
      canvas.save();

      // 下面这段代码的主要目的是在画布的中心点进行旋转操作，而不是在默认的左上角。
      // 先将画布原点平移到中心点，接着进行旋转操作，然后再将原点平移到左上角。
      // 这样可以实现在中心点的旋转效果。
      //
      // 1.
      // 这行代码将画布进行平移操作，将原点（0,0）移动到画布的中心点。
      // 这里size.width / 2表示水平方向的一半距离，size.height / 2表示垂直方向的一半距离。
      canvas.translate(size.width / 2, size.height / 2);
      // 2.
      // 这行代码将画布进行旋转操作。
      // rect.tween.transform(animation.value)是一个值在0到1之间的浮点数，表示动画进度。
      // 将这个值乘以2 * pi（即一个圆周）得到一个弧度值，作为画布旋转的角度。
      // 这样，随着animation.value的变化，画布会不断旋转。
      canvas.rotate(rect.tween.transform(animation.value) * pi * 2);
      // 3.
      // 这行代码将画布再次进行平移操作，但是这次是将原点从画布中心点移回到左上角（坐标系原点）。
      // -size.width / 2表示水平方向的一半距离的相反数，-size.height / 2表示垂直方向的一半距离的相反数。
      canvas.translate(-size.width / 2, -size.height / 2);

      // Then draw the rectangle
      canvas.drawRRect(
          funkyRect,
          Paint()
            ..blendMode = blendMode
            ..strokeWidth = rect.strokeWidth
            ..style = PaintingStyle.stroke
            ..color = rect.colour);

      canvas.restore();
    }

    // Undo the saveLayer
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  RRect _buildFunkyRect(Size size) {
    if (size != _cachedSize) {
      _cachedFunkyRect = RRect.fromLTRBAndCorners(
        0,
        0,
        size.width,
        size.height,
        topLeft: Radius.elliptical(
          size.width * 1.153,
          size.height * 1.253,
        ),
        topRight: Radius.elliptical(
          size.width * 1.253,
          size.height * 1.253,
        ),
        bottomLeft: Radius.elliptical(
          size.width * 1.253,
          size.height * 1.53,
        ),
        bottomRight: Radius.elliptical(
          size.width * 1.53,
          size.height * 1.253,
        ),
      );

      _cachedSize = size;
    }

    return _cachedFunkyRect;
  }
}
