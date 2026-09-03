import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          'Settings',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _buildSection(context, 'Appearance'),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Theme Mode',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    isDark ? 'Dark Theme' : 'Light Theme',
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (_) {
                      context.read<ThemeBloc>().add(ToggleThemeEvent());
                    },
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),
          _buildSection(context, 'Accessibility & Audio'),
          _buildSettingItem(context, Icons.record_voice_over_rounded, 'Voice Speed', 'Normal'),
          _buildSettingItem(context, Icons.vibration_rounded, 'Haptic Feedback', 'On'),

          const SizedBox(height: 24),
          _buildSection(context, 'General'),
          _buildSettingItem(context, Icons.notifications_none_rounded, 'Notifications', 'Enabled'),
          _buildSettingItem(context, Icons.language_rounded, 'Language', 'English (US)'),

          const SizedBox(height: 24),
          _buildSection(context, 'About'),
          _buildSettingItem(context, Icons.info_outline_rounded, 'Version', 'v0.1.0'),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: isDark ? Colors.white38 : Colors.black45,
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        trailing: Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
