import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

enum SnackBarType { success, error, info }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
  }) {
    final theme = Theme.of(context);
    
    Color baseColor;
    IconData icon;
    List<Color> gradientColors;

    switch (type) {
      case SnackBarType.success:
        baseColor = const Color(0xFF4CAF50);
        icon = Icons.check_circle_rounded;
        gradientColors = [const Color(0xFF43A047), const Color(0xFF66BB6A)];
        break;
      case SnackBarType.error:
        baseColor = const Color(0xFFE53935);
        icon = Icons.error_rounded;
        gradientColors = [const Color(0xFFD32F2F), const Color(0xFFEF5350)];
        break;
      case SnackBarType.info:
        baseColor = const Color(0xFF1E88E5);
        icon = Icons.info_rounded;
        gradientColors = [const Color(0xFF1976D2), const Color(0xFF42A5F5)];
        break;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        duration: const Duration(seconds: 4),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: baseColor.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.1, 1.1), duration: 1000.ms, curve: Curves.easeInOut),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTitle(type),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      message,
                      style: GoogleFonts.outfit(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate()
         .fadeIn(duration: 500.ms)
         .slideY(begin: 0.5, end: 0, curve: Curves.easeOutBack)
         .shimmer(delay: 1000.ms, duration: 2000.ms, color: Colors.white24),
      ),
    );
  }

  static String _getTitle(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return 'Success';
      case SnackBarType.error:
        return 'Error';
      case SnackBarType.info:
        return 'Information';
    }
  }
}
