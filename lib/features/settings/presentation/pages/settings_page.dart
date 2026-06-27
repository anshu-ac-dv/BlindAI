import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          'Settings',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSection(context, 'General'),
          _buildSettingItem(context, Icons.notifications_none_rounded, 'Notifications', 'Manage alerts and sounds'),
          _buildSettingItem(context, Icons.language_rounded, 'Language', 'English (US)'),
          const SizedBox(height: 32),
          _buildSection(context, 'Accessibility'),
          _buildSettingItem(context, Icons.record_voice_over_rounded, 'Voice Speed', 'Normal'),
          _buildSettingItem(context, Icons.vibration_rounded, 'Haptic Feedback', 'On'),
          const SizedBox(height: 32),
          _buildSection(context, 'About'),
          _buildSettingItem(context, Icons.info_outline_rounded, 'Version', '0.1.0'),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: isDark ? Colors.white24 : Colors.black26,
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        trailing: Text(
          value,
          style: GoogleFonts.outfit(
            color: isDark ? Colors.white38 : Colors.black38,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
