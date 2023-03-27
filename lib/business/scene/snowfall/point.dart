import 'dart:math';

class Point {
  double x = 0;
  double y = 0;

  Point([this.x = 0, this.y = 0]);

  double distance(Point p) {
    double x = this.x - p.x;
    double y = this.y - p.y;
    return sqrt(x * x + y * y);
  }

  /// 以插值因子[f]找到当前点和点[p]之间的点，其中插值因子[f]介于0和1之间
  Point interpolate(Point p, double f) {
    return Point(p.x + (x - p.x) * f, p.y + (y - p.y) * f);
  }

  double length() {
    return sqrt(x * x + y * y);
  }

  static Point pointsInterpolation(Point p0, Point p1, double f) {
    return p0.interpolate(p1, f);
  }

  static Point polarToPoint(double l, double r) {
    return Point(l * cos(r), l * sin(r));
  }
}
