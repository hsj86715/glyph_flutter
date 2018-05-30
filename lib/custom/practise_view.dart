import 'package:flutter/material.dart';

import 'hexagram_view.dart';

class _PractisePainter extends HexagramPainter {
  _PractisePainter(List<List<int>> paths) : super(paths: paths);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    super.paint(canvas, size);
  }
}

class PractiseView extends StatefulWidget {
  final List<int> path = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  createState() => new _PractiseViewState();
}

class _PractiseViewState extends State<PractiseView> {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(painter: new _PractisePainter([widget.path]));
  }
}
