import 'package:flutter/material.dart';

class Species2Painter extends CustomPainter {
  final int stage; // 1-3 stages
  Species2Painter(this.stage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final centerX = size.width / 2;

    if (stage == 1) {
      // Stage 1: Small conifer seedling
      paint.color = const Color(0xFF2E7D32);
      
      // Draw main stem
      paint.color = const Color(0xFF5D4037);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.75),
          width: size.width * 0.025,
          height: size.height * 0.3,
        ),
        paint,
      );

      // Draw needle clusters
      paint.color = const Color(0xFF2E7D32);
      paint.strokeWidth = 1.5;
      paint.style = PaintingStyle.stroke;
      
      // Small needle-like branches
      for (int i = 0; i < 6; i++) {
        double y = size.height * 0.4 + (i * 8);
        double length = 15.0 - (i * 1.5);
        
        Path needlePath = Path();
        needlePath.moveTo(centerX - length, y);
        needlePath.lineTo(centerX + length, y);
        canvas.drawPath(needlePath, paint);
      }

      // Simple root
      paint.color = const Color(0xFF5D4037);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.95),
          width: size.width * 0.02,
          height: size.height * 0.1,
        ),
        paint,
      );

    } else if (stage == 2) {
      // Stage 2: Young pine with distinctive layers
      final trunkHeight = size.height * 0.4;
      final trunkWidth = size.width * 0.06;
      
      // Draw trunk
      paint.color = Colors.brown.shade800;
      paint.style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight / 2),
          width: trunkWidth,
          height: trunkHeight,
        ),
        paint,
      );

      // Draw triangular pine layers
      paint.color = const Color(0xFF1B5E20);
      
      Path pinePath = Path();
      // Bottom layer
      pinePath.moveTo(centerX - size.width * 0.3, size.height - trunkHeight);
      pinePath.lineTo(centerX, size.height - trunkHeight - 60);
      pinePath.lineTo(centerX + size.width * 0.3, size.height - trunkHeight);
      pinePath.close();
      canvas.drawPath(pinePath, paint);
      
      // Middle layer
      paint.color = const Color(0xFF2E7D32);
      Path middlePath = Path();
      middlePath.moveTo(centerX - size.width * 0.25, size.height - trunkHeight - 30);
      middlePath.lineTo(centerX, size.height - trunkHeight - 80);
      middlePath.lineTo(centerX + size.width * 0.25, size.height - trunkHeight - 30);
      middlePath.close();
      canvas.drawPath(middlePath, paint);

    } else if (stage == 3) {
      // Stage 3: Mature pine tree
      final trunkHeight = size.height * 0.45;
      final trunkWidth = size.width * 0.08;
      
      // Draw thick trunk
      paint.color = Colors.brown.shade900;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight / 2),
          width: trunkWidth,
          height: trunkHeight,
        ),
        paint,
      );

      // Draw multiple pine layers for mature look
      paint.color = const Color(0xFF1B5E20);
      
      // Bottom layer (largest)
      Path bottomPath = Path();
      bottomPath.moveTo(centerX - size.width * 0.35, size.height - trunkHeight);
      bottomPath.lineTo(centerX, size.height - trunkHeight - 70);
      bottomPath.lineTo(centerX + size.width * 0.35, size.height - trunkHeight);
      bottomPath.close();
      canvas.drawPath(bottomPath, paint);
      
      // Middle layer
      paint.color = const Color(0xFF2E7D32);
      Path middlePath = Path();
      middlePath.moveTo(centerX - size.width * 0.28, size.height - trunkHeight - 35);
      middlePath.lineTo(centerX, size.height - trunkHeight - 90);
      middlePath.lineTo(centerX + size.width * 0.28, size.height - trunkHeight - 35);
      middlePath.close();
      canvas.drawPath(middlePath, paint);
      
      // Top layer
      paint.color = const Color(0xFF388E3C);
      Path topPath = Path();
      topPath.moveTo(centerX - size.width * 0.2, size.height - trunkHeight - 65);
      topPath.lineTo(centerX, size.height - trunkHeight - 110);
      topPath.lineTo(centerX + size.width * 0.2, size.height - trunkHeight - 65);
      topPath.close();
      canvas.drawPath(topPath, paint);

      // Draw fallen pine needles/cones
      paint.color = Colors.brown.shade600;
      paint.style = PaintingStyle.fill;
      for (int i = 0; i < 8; i++) {
        canvas.drawCircle(
          Offset(centerX - 40 + (i * 10), size.height - 5),
          2.0,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
