import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../../../core/presentation/widgets/app_logo.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/home_drawer.dart';
import '../widgets/suggestion_card.dart';
import '../widgets/bottom_input_bar.dart';
import '../../../../injection_container.dart';
import '../../../vision/presentation/pages/describe_scene_page.dart';
import '../../../vision/presentation/pages/read_text_page.dart';
import '../../../vision/presentation/pages/identify_color_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _onFeatureTap(BuildContext context, String feature) {
    context.read<HomeBloc>().add(CommandSubmitted('Start $feature'));
    
    Widget nextPage;
    switch (feature) {
      case 'Describe Scene':
        nextPage = const DescribeScenePage();
        break;
      case 'Read Text':
        nextPage = const ReadTextPage();
        break;
      case 'Identify Color':
        nextPage = const IdentifyColorPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeCommandSuccess) {
              CustomSnackBar.show(context,
                  message: state.message, type: SnackBarType.success);
            } else if (state is HomeError) {
              CustomSnackBar.show(context,
                  message: state.message, type: SnackBarType.error);
            }
          },
          child: Scaffold(
            drawer: HomeDrawer(isDark: isDark),
            appBar: _buildAppBar(context, isDark),
            body: Stack(
              children: [
                if (isDark) _buildBackgroundAura(),
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 28),
                              _buildWelcomeText(context, isDark),
                              const SizedBox(height: 8),
                              _buildSubTitle(isDark),
                              const SizedBox(height: 36),
                              _buildSuggestionCards(context),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      BottomInputBar(
                        onSendMessage: (msg) => context
                            .read<HomeBloc>()
                            .add(CommandSubmitted(msg)),
                        onVoicePressed: () => CustomSnackBar.show(context,
                            message: 'Listening...', type: SnackBarType.info),
                        onGalleryPressed: () => CustomSnackBar.show(context,
                            message: 'Opening Gallery...',
                            type: SnackBarType.info),
                      ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppLogo(size: 26, isAnimated: false),
          const SizedBox(width: 10),
          Text(
            'BlindAI',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: isDark ? Colors.white : const Color(0xFF1A1A24),
            ),
          ),
        ],
      ),
      leading: Builder(
        builder: (context) => BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF673AB7), Color(0xFFFF4081)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        authState.user.initials,
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
              icon: Icon(Icons.menu_rounded,
                  color: isDark ? Colors.white70 : const Color(0xFF1A1A24)),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: isDark ? Colors.white70 : const Color(0xFF1A1A24),
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBackgroundAura() {
    return Positioned(
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
    );
  }

  Widget _buildWelcomeText(BuildContext context, bool isDark) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final name = (authState is Authenticated) ? authState.user.firstName : "Friend";
        return Row(
          children: [
            Text(
              'Hello, $name',
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1A1A24),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '👋',
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0);
      },
    );
  }

  Widget _buildSubTitle(bool isDark) {
    return Text(
      'How can I help you perceive the world today?',
      style: GoogleFonts.outfit(
        fontSize: 16,
        color: isDark ? Colors.white60 : const Color(0xFF5A5C69),
        fontWeight: FontWeight.w400,
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 500.ms);
  }

  Widget _buildSuggestionCards(BuildContext context) {
    return Column(
      children: [
        SuggestionCard(
          title: 'Describe Scene',
          subtitle: 'Identify objects, surroundings, and people.',
          icon: Icons.visibility_outlined,
          accentColor: const Color(0xFF673AB7),
          onTap: () => _onFeatureTap(context, 'Describe Scene'),
        ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.08, end: 0),
        const SizedBox(height: 16),
        SuggestionCard(
          title: 'Read Text',
          subtitle: 'Listen to documents, signs, or menus read aloud.',
          icon: Icons.document_scanner_rounded,
          accentColor: const Color(0xFFFF4081),
          onTap: () => _onFeatureTap(context, 'Read Text'),
        ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.08, end: 0),
        const SizedBox(height: 16),
        SuggestionCard(
          title: 'Identify Color',
          subtitle: 'Recognize exact colors in front of your camera.',
          icon: Icons.palette_outlined,
          accentColor: const Color(0xFF00BCD4),
          onTap: () => _onFeatureTap(context, 'Identify Color'),
        ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.08, end: 0),
      ],
    );
  }
}
