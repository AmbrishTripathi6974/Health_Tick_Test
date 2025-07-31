import 'package:flutter/material.dart';

// Species 1: Oak-like tree with 2 stages (seedling to young tree)
class Species1Painter extends CustomPainter {
  final int stage; // 1-2 stages
  Species1Painter(this.stage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final centerX = size.width / 2;

    if (stage == 1) {
      // Stage 1: Seedling with cotyledons and first true leaves
      paint.color = const Color(0xFF8BC34A);
      
      // Draw stem
      paint.color = const Color(0xFF4CAF50);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.7),
          width: size.width * 0.03,
          height: size.height * 0.4,
        ),
        paint,
      );

      // Draw cotyledons (rounded first leaves)
      paint.color = const Color(0xFF8BC34A);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX - size.width * 0.15, size.height * 0.3),
          width: size.width * 0.25,
          height: size.height * 0.15,
        ),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX + size.width * 0.15, size.height * 0.3),
          width: size.width * 0.25,
          height: size.height * 0.15,
        ),
        paint,
      );

      // Draw small root system
      paint.color = const Color(0xFF6B4226);
      paint.strokeWidth = 2.0;
      paint.style = PaintingStyle.stroke;
      
      Path rootPath = Path();
      rootPath.moveTo(centerX, size.height * 0.9);
      rootPath.lineTo(centerX - 15, size.height * 0.95);
      rootPath.moveTo(centerX, size.height * 0.9);
      rootPath.lineTo(centerX + 15, size.height * 0.95);
      rootPath.moveTo(centerX, size.height * 0.9);
      rootPath.lineTo(centerX, size.height);
      canvas.drawPath(rootPath, paint);

    } else if (stage == 2) {
      // Stage 2: Young tree with small trunk and fuller canopy
      final trunkHeight = size.height * 0.35;
      final trunkWidth = size.width * 0.08;
      
      // Draw trunk
      paint.color = const Color(0xFF6B4226);
      paint.style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight / 2),
          width: trunkWidth,
          height: trunkHeight,
        ),
        paint,
      );

      // Draw canopy layers
      paint.color = const Color(0xFF388E3C);
      
      // Bottom layer (largest)
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight - 10),
          width: size.width * 0.6,
          height: size.height * 0.25,
        ),
        paint,
      );
      
      // Top layer (smaller)
      paint.color = const Color(0xFF4CAF50);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight - 30),
          width: size.width * 0.45,
          height: size.height * 0.2,
        ),
        paint,
      );

      // Draw visible root system
      paint.color = const Color(0xFF6B4226);
      paint.strokeWidth = 3.0;
      paint.style = PaintingStyle.stroke;
      
      Path rootPath = Path();
      rootPath.moveTo(centerX, size.height - 5);
      rootPath.lineTo(centerX - 25, size.height);
      rootPath.moveTo(centerX, size.height - 5);
      rootPath.lineTo(centerX + 25, size.height);
      rootPath.moveTo(centerX, size.height - 5);
      rootPath.lineTo(centerX - 10, size.height);
      rootPath.moveTo(centerX, size.height - 5);
      rootPath.lineTo(centerX + 10, size.height);
      canvas.drawPath(rootPath, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
