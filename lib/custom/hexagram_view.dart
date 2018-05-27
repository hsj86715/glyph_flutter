import 'dart:math';

import 'package:flutter/material.dart';

class HexagramPainter extends CustomPainter {
  List<int> path;
  List<Point<double>> hexagramPoint;

  setPath(List<int> path) {
    this.path = path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    if (hexagramPoint == null) {
      hexagramPoint = new List();
    } else {
      hexagramPoint.clear();
    }

    Paint paint = new Paint();
    double d = min(size.width, size.height);
    _drawHexagram(canvas, paint, d);
    path = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    if (path != null) {
      _drawPath(canvas, paint, d);
      print('Path:' + path.toString());
    } else {
      print('Path is null');
    }
  }

  @override
  bool shouldRepaint(HexagramPainter oldDelegate) {
    return true;
  }

  _drawHexagram(Canvas canvas, Paint paint, double size) {
    double pointRadius = size / 15.0 > 10.0 ? 10.0 : size / 15.0;
    double center = size / 2.0;
    double radius = center - pointRadius;
    _drawEmptyCircle(canvas, paint, radius, radius, pointRadius);

    double cx, cy;
    Path path = new Path();
    for (int degree = 30; degree < 360; degree += 60) {
      if (degree % 90 != 0) {
        cx = cos(toRadians(degree)) * radius / 2.0;
        cy = sin(toRadians(degree)) * radius / 2.0;
        _drawEmptyCircle(canvas, paint, radius + cx, radius - cy, pointRadius);
      }

      cx = cos(toRadians(degree)) * radius;
      cy = sin(toRadians(degree)) * radius;
      _drawEmptyCircle(canvas, paint, radius + cx, radius - cy, pointRadius);

      if (degree == 30) {
        path.moveTo(cx + center + cos(toRadians(degree)) * pointRadius,
            center - cy - sin(toRadians(degree)) * pointRadius);
      } else {
        path.lineTo(cx + center + cos(toRadians(degree)) * pointRadius,
            center - cy - sin(toRadians(degree)) * pointRadius);
      }
    }

    path.close();
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 4.0;
    paint.color = Colors.white70;
    canvas.drawPath(path, paint);
  }

  _drawEmptyCircle(
      Canvas canvas, Paint paint, double cx, double cy, double pointRadius) {
    cx += pointRadius;
    cy += pointRadius;
    paint.color = Colors.blueGrey;
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;
    Offset offset = new Offset(cx, cy);
    canvas.drawCircle(offset, pointRadius, paint);
    hexagramPoint.add(new Point(cx, cy));

    _drawPointOrder(canvas, cx, cy, pointRadius, hexagramPoint.length);
  }

  ///[index] start with 1
  _drawPointOrder(
      Canvas canvas, double cx, double cy, double pointRadius, int order) {
    TextPainter painter = new TextPainter(
        text: new TextSpan(
          style: new TextStyle(
              color: Colors.deepOrangeAccent, fontSize: pointRadius),
          text: order.toString(),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    painter.layout();
    painter.paint(
        canvas, new Offset(cx - painter.width / 2, cy - painter.height / 2));
  }

  _drawPath(Canvas canvas, Paint paint, double size) {
    paint.strokeWidth = size / 40.0 > 10.0 ? 10.0 : size / 40.0;
    paint.strokeCap = StrokeCap.round;
    paint.color = getPathColor();
    _drawLines(canvas, paint);
  }

  _drawLines(Canvas canvas, Paint paint) {
    int position = path[0] - 1;
    Point start = hexagramPoint[position];
    for (int i = 1; i < path.length; i++) {
      position = path[i] - 1;
      Point<double> point = hexagramPoint[position];
      canvas.drawLine(
          new Offset(start.x, start.y), new Offset(point.x, point.y), paint);
      start = point;
    }
  }

  Color getPathColor({int index: 0}) {
    return Colors.white;
  }

  double toRadians(int value) =>
      (double.tryParse(value.toString())) * (pi / 180.0);
}

class HexagramView extends StatefulWidget {
  setPathArr() {}

  @override
  createState() => new _HexagramViewState();
}

class _HexagramViewState extends State<HexagramView> {
//  _setPathArr(){
//    setState(() {
//
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(painter: new HexagramPainter());
  }
}
