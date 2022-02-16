import 'package:flutter/material.dart';

class CoordinateSystemPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    int maxX = 10;
    double hlafTriangleWidth = 6;
    double triangleHeight = 12;
    double distance = size.width / (maxX*2);
    double halfLineLength = 5;
    
    Paint achsesPaint = Paint()..color = Colors.black..strokeCap = StrokeCap.butt..strokeWidth = 2;
    Paint trianglePaint = Paint()..color = Colors.black..style = PaintingStyle.fill;

    Path triangleOne = Path();
    Path triangleTwo = Path();

    triangleOne.moveTo(size.width/2 - hlafTriangleWidth, triangleHeight);
    triangleOne.lineTo(size.width/2,0);
    triangleOne.lineTo(size.width/2 + hlafTriangleWidth, triangleHeight);
    triangleOne.lineTo(size.width/2 -hlafTriangleWidth, triangleHeight);
    triangleTwo.moveTo(size.width - triangleHeight, size.height/2 - hlafTriangleWidth);
    triangleTwo.lineTo(size.width, size.height/2);
    triangleTwo.lineTo(size.width - triangleHeight, size.height/2 + hlafTriangleWidth);
    triangleTwo.lineTo(size.width - triangleHeight, size.height/2 - hlafTriangleWidth);

    //x-Achses
    canvas.drawPath(triangleTwo, trianglePaint);
    canvas.drawLine(Offset(0, size.height/2), Offset(size.width - 1, size.height/2), achsesPaint);
    for(int i = 1; i < maxX*2; i++){
      canvas.drawLine(Offset(i*distance, size.height/2 - halfLineLength), Offset(i*distance, size.height/2 + halfLineLength), achsesPaint);
    }
    //y-Achses
    for(int i = 1; i < maxX*2; i++){
      canvas.drawLine(Offset(size.height/2 - halfLineLength, i*distance), Offset(size.width/2 + halfLineLength,i*distance), achsesPaint);
    }
    canvas.drawPath(triangleOne, trianglePaint);
    canvas.drawLine(Offset(size.width/2, 1), Offset(size.width/2, size.height,), achsesPaint,);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}