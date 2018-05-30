import 'package:flutter/material.dart';

import 'hexagram_view.dart';

class _MultiGlyphPainter extends HexagramPainter {
  _MultiGlyphPainter(List<List<int>> paths) : super(paths: paths);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    super.paint(canvas, size);
  }
}

class MultiGlyphView extends StatefulWidget {
  final List<List<int>> paths = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    [1, 3, 5, 7, 9, 11, 2, 4, 6, 8, 10],
    [2, 4, 6, 8, 10, 1, 3, 5, 7, 9, 11]
  ];

  @override
  createState() => new _MultiGlyphViewState();
}

class _MultiGlyphViewState extends State<MultiGlyphView> {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(painter: new _MultiGlyphPainter(widget.paths));
  }
}
