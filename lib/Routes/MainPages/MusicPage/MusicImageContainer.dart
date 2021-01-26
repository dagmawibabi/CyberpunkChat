import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class MusicImageContainer extends CustomPainter {
  final double width;
  final double height;
  final double dentSize;
  final double extrudeDentSize;
  final double intrudeDentSize;
  final Color paintColor;
  final PaintingStyle paintingStyle;
  MusicImageContainer(
      this.width,
      this.height,
      this.dentSize,
      this.extrudeDentSize,
      this.intrudeDentSize,
      this.paintColor,
      this.paintingStyle);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = paintColor;
    paint.style = paintingStyle;
    paint.strokeWidth = paintingStyle == PaintingStyle.stroke ? 6.0 : 1.0;
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(width, 0); // ----
    path.lineTo(width, extrudeDentSize); //    |
    path.lineTo(width - intrudeDentSize, extrudeDentSize + 4); //   /
    path.lineTo(
        width - intrudeDentSize, (height - (extrudeDentSize + 4))); //   |
    path.lineTo(width, height - extrudeDentSize); //   \
    path.lineTo(width, height); //    |
    path.lineTo(dentSize, height); // ----
    path.lineTo(0.0, height - dentSize); //
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MusicImageClipper extends CustomClipper<Path> {
  final double width;
  final double height;
  final double dentSize;
  final double extrudeDentSize;
  final double intrudeDentSize;
  final Color paintColor;
  final PaintingStyle paintingStyle;
  MusicImageClipper(
      this.width,
      this.height,
      this.dentSize,
      this.extrudeDentSize,
      this.intrudeDentSize,
      this.paintColor,
      this.paintingStyle);
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = DesignElements.black;
    paint.style = paintingStyle;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0); // ----
    path.lineTo(width, extrudeDentSize); //    |
    path.lineTo(width - intrudeDentSize, extrudeDentSize + 4); //   /
    path.lineTo(
        width - intrudeDentSize, (height - (extrudeDentSize + 4))); //   |
    path.lineTo(width, height - extrudeDentSize); //   \
    path.lineTo(width, height); //    |
    path.lineTo(dentSize, height); // ----
    path.lineTo(0.0, height - dentSize); //
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
