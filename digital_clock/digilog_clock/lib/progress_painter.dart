import 'dart:math';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double percentageCompleted;
  double circleWidth;

  ProgressPainter(
      {this.defaultCircleColor,
      this.percentageCompletedCircleColor,
      this.percentageCompleted,
      this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
  }

  getPaintBorder(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Paint OutlineCirclePaint = getPaintBorder(Colors.white30);
    final p1 = Offset(-50, 50);
    final p2 = Offset(250, 150);
    final paint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 4;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width - 50 , size.height - 50 );
    canvas.drawCircle(center, radius, defaultCirclePaint);
    canvas.drawCircle(center, (radius + 40), OutlineCirclePaint);

    // canvas.drawLine(p1, p2, paint);
    // double arcAngle = 2*pi*(25 /100);
    //double arcAngle = 2*pi*(percentageCompleted /100);
    double arcAngle = ((percentageCompleted));

    double arcAngleModified = 2 * pi * (arcAngle / 60);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngleModified, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}
