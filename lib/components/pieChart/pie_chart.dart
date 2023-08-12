import 'dart:math';
import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  final int stepCount;
  final int targetStepCount;

  PieChartPainter({required this.stepCount, required this.targetStepCount});

  @override
  void paint(Canvas canvas, Size size) {
    final percentage = stepCount / targetStepCount;
    Alignment centerAligment = Alignment(size.width / 2, size.height / 2);
    final centerOffset = Offset(size.width / 2, size.height / 3);
    final outerLineColor = Color.fromARGB(255, 28, 33, 83);

    ///double radius = min(size.width / 2, size.height / 2);
    Color lineColor;
    double arcAngle = 2 * pi * (percentage / 100);
    final gradientColor;
    final gradientStops = [percentage, 1 - percentage];
    if (percentage <= 0.25) {
      lineColor = Colors.red;
      gradientColor = <Color>[Colors.red, Colors.yellow];
    } else if (percentage <= 0.5) {
      lineColor = Colors.yellow;
      gradientColor = <Color>[Colors.yellow, Colors.green];
    } else if (percentage <= 1.0) {
      lineColor = Colors.green;
      gradientColor = <Color>[Colors.green, Colors.blue];
    } else {
      lineColor = Colors.blue;
      gradientColor = <Color>[Colors.green, Colors.blue];
    }
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // final gradient = SweepGradient(
    //   center: centerAligment,
    //   startAngle: 0,
    //   endAngle: 2 * pi,
    //   colors: gradientColor,
    // );

    
    
    final outerPaint = Paint()
      ..color = outerLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

      final innerPaint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;


    canvas.drawArc(Rect.fromCircle(center: centerOffset, radius: radius / 2), -5 * pi / 4, 6 * pi / 4, false, outerPaint);

    canvas.drawArc(Rect.fromCircle(center: centerOffset, radius: radius / 2), -5 * pi / 4, 6 * pi / 4 * percentage, false, innerPaint);
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => false;
}
