import 'dart:math';
import 'package:flutter/material.dart';

class AnimationArc extends StatelessWidget {
  final int stepCount;
  final int targetStepCount;
  final double durationValue;

  const AnimationArc(
      {required this.stepCount,
      required this.targetStepCount,
      required this.durationValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double parentWidth = constraints.maxWidth;
        double parentHeight = constraints.maxHeight;
        const completeText = 'Completed!';

        return Stack(children: [
          CustomPaint(
            child: Container(),
            painter: PieChartPainter(
              stepCount: stepCount,
              targetStepCount: targetStepCount,
              durationValue: durationValue,
            ),
          ),
          Positioned(
            top: parentHeight / 3.5,
            left: 0,
            right: 0,
            child: Center(
              child: stepCount >= targetStepCount
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 18),
                          child: Text(
                            completeText,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "${(stepCount * durationValue).round()}/${targetStepCount.round()}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "${(stepCount * durationValue).round()}/${targetStepCount.round()}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ),
        ]);
      }),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final int stepCount;
  final int targetStepCount;
  double durationValue;

  PieChartPainter(
      {required this.stepCount,
      required this.targetStepCount,
      required this.durationValue});

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
      ..strokeWidth = 25.0
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
          6 * pi / 4 * percentage * durationValue,
          false,
          innerPaint);
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => true;
}
