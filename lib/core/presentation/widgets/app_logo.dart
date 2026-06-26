import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          // Outer stylized ring
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: size * 0.05,
              ),
            ),
          ).animate(target: isAnimated ? 1 : 0, onPlay: (c) => c.repeat(reverse: true))
           .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds, curve: Curves.easeInOut),

          // Middle Glowing Ring
          Container(
            width: size * 0.7,
            height: size * 0.7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  const Color(0xFF673AB7),
                  const Color(0xFFFF4081),
                  const Color(0xFF00BCD4),
                  const Color(0xFF673AB7),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF673AB7).withValues(alpha: 0.5),
                  blurRadius: size * 0.2,
                  spreadRadius: size * 0.05,
                ),
              ],
            ),
          ).animate(target: isAnimated ? 1 : 0, onPlay: (c) => c.repeat())
           .rotate(duration: 3.seconds),

          // Inner Core (The "AI Eye")
          Container(
            width: size * 0.45,
            height: size * 0.45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.blur_on_rounded,
              size: size * 0.35,
              color: const Color(0xFF0F0F15),
            ),
          ),
          
          // Lens Flare Effect
          Positioned(
            top: size * 0.25,
            left: size * 0.25,
            child: Container(
              width: size * 0.1,
              height: size * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
