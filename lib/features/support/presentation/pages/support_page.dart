import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F15) : const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSupportCard(
            context,
            Icons.help_center_rounded,
            'Help Center',
            'Read guides and common questions.',
            const Color(0xFF673AB7),
          ),
          const SizedBox(height: 16),
          _buildSupportCard(
            context,
            Icons.chat_bubble_outline_rounded,
            'Contact Support',
            'Get in touch with our team.',
            const Color(0xFFFF4081),
          ),
          const SizedBox(height: 16),
          _buildSupportCard(
            context,
            Icons.bug_report_outlined,
            'Report a Bug',
            'Help us improve BlindAI.',
            const Color(0xFF00BCD4),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 20),
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
        ],
      ),
    );
  }
}
