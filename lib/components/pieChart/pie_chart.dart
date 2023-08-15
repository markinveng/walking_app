import 'dart:math';
import 'package:flutter/material.dart';

class AnimationArc extends StatefulWidget {
  final int stepCount;
  final int targetStepCount;

  const AnimationArc({required this.stepCount, required this.targetStepCount});

  @override
  _AnimationArc createState() => _AnimationArc();
}

class _AnimationArc extends State<AnimationArc>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool animationPlayed = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut);

    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation)
      ..addListener(() {
        setState(() {
        });
      });

    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
          child: Container(),
          painter: PieChartPainter(
            stepCount: widget.stepCount,
            targetStepCount: widget.targetStepCount,
            arcAnimation: _animation.value,
          )),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final int stepCount;
  final int targetStepCount;
  double arcAnimation;

  PieChartPainter(
      {required this.stepCount,
      required this.targetStepCount,
      required this.arcAnimation});

  @override
  void paint(Canvas canvas, Size size) {
    final percentage = stepCount / targetStepCount;
    final centerAligment = Alignment(size.width / 2, size.height / 2);
    final centerOffset = Offset(size.width / 2, size.height / 3);
    final radius = min(size.width / 2, size.height / 2);
    final outerLineColor = Color.fromARGB(255, 28, 33, 83);

    ///double radius = min(size.width / 2, size.height / 2);
    final lineColor;
    double arcAngle = 2 * pi * (percentage / 100);
    dynamic gradientColor = 0;
    dynamic gradientStops;
    final beginAlignment;
    final endAlignment;

    //色の条件分岐
    if (percentage <= 0.2) {
      lineColor = Colors.red;
      gradientColor = <Color>[
        Colors.red,
        Colors.yellow,
      ];
    } else if (percentage <= 0.4) {
      lineColor = Colors.yellow;
      gradientColor = <Color>[
        Colors.yellow,
        Colors.green,
      ];
    } else if (percentage <= 0.6) {
      lineColor = Colors.green;
      gradientColor = <Color>[
        Colors.green,
        Colors.cyanAccent,
      ];
    } else if (percentage <= 0.8) {
      lineColor = Colors.cyanAccent;
      gradientColor = <Color>[
        Colors.cyanAccent,
        Colors.blue,
      ];
    } else if (percentage < 1.0) {
      lineColor = Colors.blue;
      gradientColor = <Color>[
        Colors.blue,
        Colors.purple,
      ];
    } else {
      lineColor = Colors.transparent;
      gradientColor = <Color>[
        Colors.purple,
        Colors.purple,
      ];
    }

    //グラデーションの条件分岐
    if (percentage <= 0.5) {
      beginAlignment = Alignment.bottomLeft;
      endAlignment = Alignment.topRight;
      gradientStops = [0.1, 0.9];
    } else {
      gradientStops = [0.1, 0.9];
      beginAlignment = Alignment.topRight;
      endAlignment = Alignment.bottomLeft;
    }

    final shaderRect =
        Rect.fromCircle(center: centerOffset, radius: radius / 1.4);
    final pie = Paint();
    pie.shader = LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: gradientColor,
            stops: gradientStops)
        .createShader(shaderRect);

    final outerPaint = Paint()
      ..color = outerLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30.0
      ..style = PaintingStyle.stroke;

    final innerPaint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(shaderRect.center, size.width / 3.0, pie);

    if (stepCount < targetStepCount) {
      canvas.drawArc(
          Rect.fromCircle(center: centerOffset, radius: radius / 1.5),
          -5 * pi / 4,
          6 * pi / 4,
          false,
          outerPaint);

      canvas.drawArc(
          Rect.fromCircle(center: centerOffset, radius: radius / 1.5),
          -5 * pi / 4,
          6 * pi / 4 * percentage * arcAnimation,
          false,
          innerPaint);
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => true;
}
