import 'package:flutter/cupertino.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class DentContainer extends CustomPainter {
  final double width;
  final double height;
  final double dentSize;
  final double bezierSize;
  final Color paintColor;
  final PaintingStyle paintingStyle;
  DentContainer(this.width, this.height, this.dentSize, this.bezierSize,
      this.paintColor, this.paintingStyle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = paintColor;
    paint.style = paintingStyle;
    paint.strokeWidth = paintingStyle == PaintingStyle.stroke ? 2.0 : 1.0;
    Path path = Path();
    path.moveTo(dentSize, 0);
    path.lineTo(width - bezierSize, 0);
    path.quadraticBezierTo(width, 0, width, bezierSize);
    path.lineTo(width, height - dentSize);
    path.lineTo(width - dentSize, height);
    path.lineTo(0 + bezierSize, height);
    path.quadraticBezierTo(0, height, 0, height - bezierSize);
    path.lineTo(0, dentSize);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
