// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SemiCircle extends StatelessWidget {
  final Color color;

  const SemiCircle({super.key, required this.color, required int size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi,
      child: CustomPaint(
        painter: _SemiCirclePainter(color: color),
        size: Size.fromHeight(MediaQuery.of(context).size.height / 2),
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  final Color color;

  _SemiCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height), 0, math.pi, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
