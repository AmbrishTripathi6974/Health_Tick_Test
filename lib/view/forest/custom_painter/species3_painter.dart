import 'package:flutter/material.dart';

class Species3Painter extends CustomPainter {
  final int stage; // 1-4 stages
  Species3Painter(this.stage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final centerX = size.width / 2;

    if (stage == 1) {
      // Stage 1: Sprouting seed with first leaves
      // Draw soil line
      paint.color = Colors.brown.shade300;
      canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.8, size.width, size.height * 0.2),
        paint,
      );

      // Draw emerging shoot
      paint.color = const Color(0xFF689F38);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.7),
          width: size.width * 0.04,
          height: size.height * 0.2,
        ),
        paint,
      );

      // Draw first pair of leaves
      paint.color = const Color(0xFF8BC34A);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX - size.width * 0.12, size.height * 0.55),
          width: size.width * 0.2,
          height: size.height * 0.1,
        ),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX + size.width * 0.12, size.height * 0.55),
          width: size.width * 0.2,
          height: size.height * 0.1,
        ),
        paint,
      );

    } else if (stage == 2) {
      // Stage 2: Young sapling with multiple leaves
      final stemHeight = size.height * 0.5;
      
      // Draw main stem
      paint.color = Colors.green.shade700;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height - stemHeight / 2),
          width: size.width * 0.05,
          height: stemHeight,
        ),
        paint,
      );

      // Draw multiple leaf clusters
      paint.color = Colors.teal.shade400;
      
      // Bottom leaves
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX - size.width * 0.15, size.height * 0.7),
          width: size.width * 0.25,
          height: size.height * 0.12,
        ),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX + size.width * 0.15, size.height * 0.7),
          width: size.width * 0.25,
          height: size.height * 0.12,
        ),
        paint,
      );
      
      // Middle leaves
      paint.color = Colors.teal.shade500;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX - size.width * 0.1, size.height * 0.55),
          width: size.width * 0.22,
          height: size.height * 0.1,
        ),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX + size.width * 0.1, size.height * 0.55),
          width: size.width * 0.22,
          height: size.height * 0.1,
        ),
        paint,
      );

      // Top leaves
      paint.color = Colors.teal.shade600;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.4),
          width: size.width * 0.18,
          height: size.height * 0.08,
        ),
        paint,
      );

    } else if (stage == 3) {
      // Stage 3: Mature tree with trunk and full canopy
      final trunkHeight = size.height * 0.4;
      final trunkWidth = size.width * 0.07;
      
      // Draw trunk
      paint.color = Colors.deepOrange.shade800;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight / 2),
          width: trunkWidth,
          height: trunkHeight,
        ),
        paint,
      );

      // Draw main canopy
      paint.color = Colors.teal.shade600;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight - 40),
          width: size.width * 0.7,
          height: size.height * 0.4,
        ),
        paint,
      );

      // Add texture with smaller leaf clusters
      paint.color = Colors.teal.shade500;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX - size.width * 0.15, size.height - trunkHeight - 30),
          width: size.width * 0.3,
          height: size.height * 0.15,
        ),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX + size.width * 0.15, size.height - trunkHeight - 30),
          width: size.width * 0.3,
          height: size.height * 0.15,
        ),
        paint,
      );

    } else if (stage == 4) {
      // Stage 4: Old tree with thick trunk, full canopy, and fallen leaves
      final trunkHeight = size.height * 0.45;
      final trunkWidth = size.width * 0.1;
      
      // Draw thick, gnarled trunk
      paint.color = Colors.brown.shade900;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight / 2),
          width: trunkWidth,
          height: trunkHeight,
        ),
        paint,
      );

      // Add trunk texture/bark lines
      paint.color = Colors.brown.shade700;
      paint.strokeWidth = 2.0;
      paint.style = PaintingStyle.stroke;
      for (int i = 0; i < 5; i++) {
        canvas.drawLine(
          Offset(centerX - trunkWidth/3, size.height - trunkHeight + (i * 20)),
          Offset(centerX + trunkWidth/3, size.height - trunkHeight + (i * 20)),
          paint,
        );
      }

      // Draw massive canopy
      paint.style = PaintingStyle.fill;
      paint.color = Colors.teal.shade700;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height - trunkHeight - 50),
          width: size.width * 0.85,
          height: size.height * 0.5,
        ),
        paint,
      );

      // Add canopy layers for depth
      paint.color = Colors.teal.shade600;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX - size.width * 0.1, size.height - trunkHeight - 40),
          width: size.width * 0.4,
          height: size.height * 0.2,
        ),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX + size.width * 0.1, size.height - trunkHeight - 40),
          width: size.width * 0.4,
          height: size.height * 0.2,
        ),
        paint,
      );

      // Draw fallen leaves around base
      paint.color = Colors.orange.shade700;
      for (int i = 0; i < 12; i++) {
        double x = centerX - 60 + (i * 10);
        double y = size.height - 8;
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x, y),
            width: 6,
            height: 4,
          ),
          paint,
        );
      }

      // Add some brown fallen leaves
      paint.color = Colors.brown.shade600;
      for (int i = 0; i < 8; i++) {
        double x = centerX - 40 + (i * 10);
        double y = size.height - 4;
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x, y),
            width: 5,
            height: 3,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}