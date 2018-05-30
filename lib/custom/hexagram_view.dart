import 'dart:math';

import 'package:flutter/material.dart';

abstract class HexagramPainter extends CustomPainter {
  final List<List<int>> paths;

  HexagramPainter({this.paths});

  @override
  void paint(Canvas canvas, Size size) {
    print(size);

    Paint paint = new Paint();
    var d = min(size.width, size.height);
    var points = new List<Point<num>>();
//    canvas.drawColor(Colors.white, BlendMode.clear);
    drawHexagram(canvas, paint, d, points);
    if (paths != null && paths.isNotEmpty) {
      drawPath(canvas, paint, d, points);
      print('Path:' + paths.toString());
    } else {
      print('Path is null');
    }
  }

  @override
  bool shouldRepaint(HexagramPainter oldDelegate) {
    return paths != oldDelegate.paths;
  }

  drawHexagram(Canvas canvas, Paint paint, num size, List<Point<num>> points) {
    var pointRadius = size / 15.0 > 10.0 ? 10.0 : size / 15.0;
    var center = size / 2.0;
    var radius = center - pointRadius;
    drawEmptyCircle(canvas, paint, radius, radius, pointRadius, points);

    var cx, cy;
    var path = new Path();
    for (var degree = 30; degree < 360; degree += 60) {
      if (degree % 90 != 0) {
        cx = cos(toRadians(degree)) * radius / 2.0;
        cy = sin(toRadians(degree)) * radius / 2.0;
        drawEmptyCircle(
            canvas, paint, radius + cx, radius - cy, pointRadius, points);
      }

      cx = cos(toRadians(degree)) * radius;
      cy = sin(toRadians(degree)) * radius;
      drawEmptyCircle(
          canvas, paint, radius + cx, radius - cy, pointRadius, points);

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

  drawEmptyCircle(Canvas canvas, Paint paint, num cx, num cy, num pointRadius,
      List<Point<num>> points) {
    cx += pointRadius;
    cy += pointRadius;
    paint.color = Colors.blueGrey;
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;
    var offset = new Offset(cx, cy);
    canvas.drawCircle(offset, pointRadius, paint);
    points.add(new Point(cx, cy));

    drawPointOrder(canvas, cx, cy, pointRadius, points.length);
  }

  ///[index] start with 1
  drawPointOrder(Canvas canvas, num cx, num cy, num pointRadius, int order) {
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

  drawPath(Canvas canvas, Paint paint, num size, List<Point<num>> points) {
    paint.strokeWidth = size / 40.0 > 10.0 ? 10.0 : size / 40.0;
    paint.strokeCap = StrokeCap.round;
    paint.color = getPathColor();
    drawLines(canvas, paint, points);
  }

  drawLines(Canvas canvas, Paint paint, List<Point<num>> points,
      [int pathIdx = 0]) {
    var position = paths[pathIdx][0] - 1;
    var start = points[position];
    for (var i = 1; i < paths[pathIdx].length; i++) {
      position = paths[pathIdx][i] - 1;
      var point = points[position];
      canvas.drawLine(
          new Offset(start.x, start.y), new Offset(point.x, point.y), paint);
      start = point;
    }
  }

  Color getPathColor([index = 0]) {
    return Colors.white;
  }

  num toRadians(num value) => value * (pi / 180.0);
}

//class HexagramView extends StatefulWidget {
//  final List<int> path = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
//
//  @override
//  createState() => new _HexagramViewState();
//}
//
//class _HexagramViewState extends State<HexagramView> {
//  @override
//  Widget build(BuildContext context) {
//    return new CustomPaint(painter: new HexagramPainter(paths: [widget.path]));
//  }
//}
