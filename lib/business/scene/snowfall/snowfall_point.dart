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

  static SnowfallPoint polarToPoint(double l, double r) {
    return SnowfallPoint(l * cos(r), l * sin(r));
  }

  SnowfallPoint operator +(SnowfallPoint p) {
    return SnowfallPoint(x + p.x, y + p.y);
  }
}
