import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../../features/auth/presentation/pages/login_page.dart';
import '../../../../core/presentation/widgets/app_logo.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSuggestion(String feature) {
    CustomSnackBar.show(
      context,
      message: 'Starting $feature...',
      type: SnackBarType.info,
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    final message = _messageController.text;
    _messageController.clear();
    
    CustomSnackBar.show(
      context,
      message: 'Processing: $message',
      type: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Scaffold(
          backgroundColor:
              isDark ? const Color(0xFF0F0F15) : const Color(0xFFF8F9FF),
          drawer: _buildDrawer(context, isDark),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(size: 24, isAnimated: false),
                const SizedBox(width: 8),
                Text(
                  'BlindAI',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            leading: Builder(
              builder: (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    final initial = (authState.user.displayName ?? authState.user.email)[0].toUpperCase();
                    return GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF673AB7), Color(0xFFFF4081)],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              initial,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return IconButton(
                    icon: Icon(Icons.menu,
                        color: isDark ? Colors.white70 : Colors.black54),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                },
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              ),
              IconButton(
                icon: Icon(Icons.logout_rounded,
                    color: isDark ? Colors.white70 : Colors.black54),
                onPressed: () {
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
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Stack(
            children: [
              // Background subtle aura
              if (isDark)
                Positioned(
                  top: 100,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF673AB7).withValues(alpha: 0.05),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF673AB7).withValues(alpha: 0.1),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),

              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                String name = "Friend";
                                if (authState is Authenticated) {
                                  final displayName =
                                      authState.user.displayName;
                                  if (displayName != null &&
                                      displayName.isNotEmpty) {
                                    name = displayName.split(' ').first;
                                  } else {
                                    name =
                                        authState.user.email.split('@').first;
                                    name = name.isNotEmpty
                                        ? '${name[0].toUpperCase()}${name.substring(1)}'
                                        : 'Friend';
                                  }
                                }
                                return Text(
                                  name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          Color(0xFF673AB7),
                                          Color(0xFFFF4081)
                                        ],
                                      ).createShader(const Rect.fromLTWH(
                                          0.0, 0.0, 200.0, 70.0)),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(duration: 600.ms)
                                    .slideY(begin: 0.2, end: 0);
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'How can I help you perceive the world today?',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                color: isDark ? Colors.white60 : Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                            const SizedBox(height: 40),

                            // Suggestion Cards
                            InkWell(
                              onTap: () => _handleSuggestion('Describe Scene'),
                              borderRadius: BorderRadius.circular(24),
                              child: _buildSuggestionCard(
                                context,
                                'Describe Scene',
                                'Identify objects and people around you.',
                                Icons.visibility_outlined,
                                const Color(0xFF673AB7),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .slideX(begin: 0.1, end: 0),

                            const SizedBox(height: 16),

                            InkWell(
                              onTap: () => _handleSuggestion('Read Text'),
                              borderRadius: BorderRadius.circular(24),
                              child: _buildSuggestionCard(
                                context,
                                'Read Text',
                                'Listen to documents, signs, or menus.',
                                Icons.text_fields_rounded,
                                const Color(0xFFFF4081),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 500.ms)
                                .slideX(begin: 0.1, end: 0),

                            const SizedBox(height: 16),

                            InkWell(
                              onTap: () => _handleSuggestion('Identify Color'),
                              borderRadius: BorderRadius.circular(24),
                              child: _buildSuggestionCard(
                                context,
                                'Identify Color',
                                'Know exactly what colors are in front of you.',
                                Icons.palette_outlined,
                                const Color(0xFF00BCD4),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 600.ms)
                                .slideX(begin: 0.1, end: 0),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Input Bar (Gemini Style)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              isDark ? const Color(0xFF1E1E26) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add_photo_alternate_outlined,
                                  color: theme.colorScheme.primary),
                              onPressed: () {
                                CustomSnackBar.show(
                                  context,
                                  message: 'Opening Gallery...',
                                  type: SnackBarType.info,
                                );
                              },
                            ),
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                onSubmitted: (_) => _sendMessage(),
                                decoration: InputDecoration(
                                  hintText: 'Enter a prompt here',
                                  hintStyle: TextStyle(
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.black38),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: false,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _isTyping ? _sendMessage : () {
                                CustomSnackBar.show(
                                  context,
                                  message: 'Listening...',
                                  type: SnackBarType.info,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF673AB7),
                                      Color(0xFFFF4081)
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  _isTyping ? Icons.send_rounded : Icons.mic_none_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 800.ms)
                        .slideY(begin: 0.5, end: 0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? const Color(0xFF1E1E26) : Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF673AB7), const Color(0xFFFF4081).withValues(alpha: 0.8)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(size: 60, isAnimated: true),
                  const SizedBox(height: 12),
                  Text(
                    'BlindAI',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text('Activity History'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: const Text('Help & Support'),
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'v0.1.0',
              style: TextStyle(color: isDark ? Colors.white24 : Colors.black26),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(BuildContext context, String title,
      String subtitle, IconData icon, Color accentColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: accentColor, size: 28),
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
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
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
          Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: isDark ? Colors.white24 : Colors.black26),
        ],
      ),
    );
  }
}
