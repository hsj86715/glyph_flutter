import 'package:flutter/material.dart';

import 'hexagram_view.dart';

class _IngressGlyphPainter extends HexagramPainter {
  _IngressGlyphPainter(List<List<int>> paths) : super(paths: paths);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    super.paint(canvas, size);
  }
}

class GlyphView extends StatefulWidget {
  final List<int> path = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  State<StatefulWidget> createState() {
    return new _GlyphViewState();
  }
}

class _GlyphViewState extends State<GlyphView> {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(painter: new _IngressGlyphPainter([widget.path]));
  }
}
