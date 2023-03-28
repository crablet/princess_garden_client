import 'dart:math';

class SnowfallPoint {
  double x = 0;
  double y = 0;

  SnowfallPoint([this.x = 0, this.y = 0]);

  double distance(SnowfallPoint p) {
    double x = this.x - p.x;
    double y = this.y - p.y;
    return sqrt(x * x + y * y);
  }

  /// 以插值因子[f]找到当前点和点[p]之间的点，其中插值因子[f]介于0和1之间
  SnowfallPoint interpolate(SnowfallPoint p, double f) {
    return SnowfallPoint(p.x + (x - p.x) * f, p.y + (y - p.y) * f);
  }

  double length() {
    return sqrt(x * x + y * y);
  }

  static SnowfallPoint pointsInterpolation(
      SnowfallPoint p0, SnowfallPoint p1, double f) {
    return p0.interpolate(p1, f);
  }

  static SnowfallPoint polarToPoint(double l, double r) {
    return SnowfallPoint(l * cos(r), l * sin(r));
  }

  SnowfallPoint operator +(SnowfallPoint p) {
    return SnowfallPoint(x + p.x, y + p.y);
  }
}
