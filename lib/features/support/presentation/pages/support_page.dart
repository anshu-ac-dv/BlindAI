import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, 
                color: isDark ? Colors.white70 : Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Help & Support',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          _buildSupportCard(
            context,
            Icons.help_center_rounded,
            'Help Center',
            'Read guides and common questions.',
            const Color(0xFF673AB7),
            onTap: () => CustomSnackBar.show(context, 
                message: 'Help Center coming soon!', 
                type: SnackBarType.info),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          _buildSupportCard(
            context,
            Icons.chat_bubble_outline_rounded,
            'Contact Support',
            'Get in touch with our team.',
            const Color(0xFFFF4081),
            onTap: () => CustomSnackBar.show(context, 
                message: 'Support chat opening...', 
                type: SnackBarType.info),
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          _buildSupportCard(
            context,
            Icons.bug_report_outlined,
            'Report a Bug',
            'Help us improve BlindAI.',
            const Color(0xFF00BCD4),
            onTap: () => CustomSnackBar.show(context, 
                message: 'Bug report form opened.', 
                type: SnackBarType.info),
          ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.08, end: 0),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, 
    IconData icon, 
    String title, 
    String subtitle, 
    Color color,
    {required VoidCallback onTap}
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark 
                  ? Colors.white10
                  : Colors.black.withValues(alpha: 0.05),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isDark ? Colors.white24 : Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
