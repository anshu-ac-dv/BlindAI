import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class AppLogo extends StatelessWidget {
  final double size;
  final bool isAnimated;

  const AppLogo({
    super.key,
    this.size = 100,
    this.isAnimated = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4285F4).withValues(alpha: 0.2),
                  blurRadius: size * 0.4,
                  spreadRadius: size * 0.1,
                ),
              ],
            ),
          ).animate(target: isAnimated ? 1 : 0, onPlay: (c) => c.repeat(reverse: true))
           .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2.seconds),

          // The Gemini-style Sparkle
          CustomPaint(
            size: Size(size, size),
            painter: _GeminiSparklePainter(),
          ),
          
          // Internal soft glow
          Container(
            width: size * 0.15,
            height: size * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: size * 0.1,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    )
    .animate(target: isAnimated ? 1 : 0, onPlay: (c) => c.repeat(reverse: true))
    .scale(
      begin: const Offset(1, 1),
      end: const Offset(1.05, 1.05),
      duration: 3.seconds,
      curve: Curves.easeInOut,
    )
    .shimmer(
      delay: 2.seconds,
      duration: 2.seconds,
      color: Colors.white.withValues(alpha: 0.3),
    );
  }
}

class _GeminiSparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4285F4), // Blue
          Color(0xFF9B72CB), // Purple
          Color(0xFFD96570), // Pinkish
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final path = Path();
    
    // Draw a 4-pointed star with curved inwards sides (like Gemini)
    for (int i = 0; i < 4; i++) {
      double angle = i * math.pi / 2;
      double nextAngle = (i + 1) * math.pi / 2;
      double midAngle = (angle + nextAngle) / 2;

      if (i == 0) path.moveTo(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle));

      // Control points for the quadratic bezier curve to create the "inward" effect
      double cpRadius = radius * 0.2; // How "thin" the star is in the middle
      path.quadraticBezierTo(
        center.dx + cpRadius * math.cos(midAngle),
        center.dy + cpRadius * math.sin(midAngle),
        center.dx + radius * math.cos(nextAngle),
        center.dy + radius * math.sin(nextAngle),
      );
    }

    path.close();
    canvas.drawPath(path, paint);
    
    // Add a smaller white layer for depth
    final whitePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.8),
          Colors.white.withValues(alpha: 0.2),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.6));
      
    final innerPath = Path();
     for (int i = 0; i < 4; i++) {
      double angle = i * math.pi / 2;
      double nextAngle = (i + 1) * math.pi / 2;
      double midAngle = (angle + nextAngle) / 2;

      double innerRadius = radius * 0.6;
      if (i == 0) innerPath.moveTo(center.dx + innerRadius * math.cos(angle), center.dy + innerRadius * math.sin(angle));

      double cpRadius = innerRadius * 0.15;
      innerPath.quadraticBezierTo(
        center.dx + cpRadius * math.cos(midAngle),
        center.dy + cpRadius * math.sin(midAngle),
        center.dx + innerRadius * math.cos(nextAngle),
        center.dy + innerRadius * math.sin(nextAngle),
      );
    }
    innerPath.close();
    canvas.drawPath(innerPath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
