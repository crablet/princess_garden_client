import 'dart:math';

import 'package:flutter/material.dart';

class GameOfLifePainter extends CustomPainter {
  late List<List<bool>> cells;

  double cellWidth, cellHeight;

  static const xCount = 53, yCount = 53;
  static const Color cellColor = Colors.lightBlueAccent;

  List<List<bool>> hiddenMat1 =
      List.generate(xCount, (_) => List.generate(yCount, (_) => false));
  List<List<bool>> hiddenMat2 =
      List.generate(xCount, (_) => List.generate(yCount, (_) => false));

  GameOfLifePainter(double width, double height)
      : cellWidth = width / xCount,
        cellHeight = height / yCount {
    cells = hiddenMat1;
    for (int i = 0; i < xCount; ++i) {
      for (int j = 0; j < yCount; ++j) {
        cells[i][j] = Random().nextBool();
      }
    }
  }

  void update() {
    final next = (cells == hiddenMat1 ? hiddenMat2 : hiddenMat1);
    for (int i = 0; i < xCount; ++i) {
      for (int j = 0; j < yCount; ++j) {
        // 游戏规则：
        // 如果一个存活的细胞周围有2个或3个存活的相邻细胞，那么这个细胞在下一轮中仍然存活。
        // 如果一个存活的细胞周围有少于2个存活的相邻细胞（即1个或0个），那么这个细胞在下一轮中死亡（因为孤立）。
        // 如果一个存活的细胞周围有超过3个存活的相邻细胞，那么这个细胞在下一轮中死亡（因为拥挤）。
        // 如果一个死亡的细胞周围正好有3个存活的相邻细胞，那么这个细胞在下一轮中复活。
        final neighboursCount = _countNeighbours(i, j);
        next[i][j] = !cells[i][j] && neighboursCount == 3 ||
            cells[i][j] && neighboursCount >= 2 && neighboursCount <= 3;
      }
    }
    cells = next;
  }

  // 计算细胞周围的存活细胞数量
  int _countNeighbours(int x, int y) {
    int count = 0;
    for (int i = x - 1; i <= x + 1; ++i) {
      for (int j = y - 1; j <= y + 1; ++j) {
        if (cells[(i + xCount) % xCount][(j + yCount) % yCount]) {
          ++count;
        }
      }
    }
    count -= (cells[x][y] ? 1 : 0); // 减去自己，因为cells[x][y]这个点也被计算了
    return count;
  }

  void _drawCell(Canvas canvas, double x, double y) {
    canvas.drawRect(
      Offset(x, y) & Size(cellWidth, cellHeight),
      Paint()..color = cellColor,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < xCount; ++i) {
      for (int j = 0; j < yCount; ++j) {
        if (cells[i][j]) {
          _drawCell(canvas, i * cellWidth, j * cellHeight);
        }
      }
    }
  }

  @override
  bool shouldRepaint(GameOfLifePainter oldDelegate) => true;
}
