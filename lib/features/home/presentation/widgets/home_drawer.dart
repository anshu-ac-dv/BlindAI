import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/presentation/widgets/app_logo.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../../features/auth/presentation/pages/login_page.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../../../../features/settings/presentation/pages/settings_page.dart';
import '../../../../features/support/presentation/pages/support_page.dart';
import '../../../../features/history/presentation/pages/history_page.dart';

class HomeDrawer extends StatelessWidget {
  final bool isDark;

  const HomeDrawer({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0F0F15) : const Color(0xFFF8F9FF),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          _buildProfileHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                _buildSectionHeader(context, 'MAIN'),
                _buildDrawerItem(
                  context,
                  icon: Icons.history_rounded,
                  title: 'Activity History',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryPage()));
                  },
                ),
                const SizedBox(height: 8),
                _buildSectionHeader(context, 'APP'),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportPage()));
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Divider(color: Colors.white10),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  textColor: const Color(0xFFFF4081),
                  iconColor: const Color(0xFFFF4081),
                  onTap: () => _handleLogout(context),
                ),
              ],
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: isDark ? Colors.white24 : Colors.black26,
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = "Guest User";
        String email = "Welcome to BlindAI";
        String initial = "G";

        if (state is Authenticated) {
          name = state.user.displayName ?? state.user.email.split('@').first;
          email = state.user.email;
          initial = name.isNotEmpty ? name[0].toUpperCase() : "U";
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF673AB7),
                const Color(0xFFFF4081).withValues(alpha: 0.9)
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF673AB7).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: GoogleFonts.outfit(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 20),
              Text(
                name,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2, end: 0),
              Text(
                email,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (iconColor ?? (isDark ? Colors.white70 : Colors.black54)).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: iconColor ?? (isDark ? Colors.white70 : Colors.black54),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? (isDark ? Colors.white : Colors.black87),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDark ? Colors.white10 : Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(size: 24, isAnimated: false),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BlindAI',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white38 : Colors.black45,
                ),
              ),
              Text(
                'v0.1.0',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: isDark ? Colors.white24 : Colors.black26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
    CustomSnackBar.show(
      context,
      message: 'Logged out successfully',
      type: SnackBarType.success,
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}
