import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'core/presentation/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Wait for the minimum animation time
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;

    // Capture context-dependent objects before further async operations
    final authBloc = context.read<AuthBloc>();
    final currentState = authBloc.state;
    
    if (currentState is Authenticated || currentState is Unauthenticated) {
      _redirect(currentState);
    } else {
      // If still initial, wait for the first definitive state from the stream
      await for (final authState in authBloc.stream) {
        if (!mounted) return;
        if (authState is Authenticated || authState is Unauthenticated) {
          _redirect(authState);
          return;
        }
      }
    }
  }

  void _redirect(AuthState state) {
    Widget nextScreen = (state is Authenticated) ? const HomeScreen() : const LoginPage();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F15), // Deep dark background
      body: Stack(
        children: [
          // Subtle Aura / Background Glow
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF673AB7).withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF673AB7).withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .move(begin: const Offset(0, 0), end: const Offset(-20, 20), duration: 5.seconds),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF4081).withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF4081).withValues(alpha: 0.15),
                    blurRadius: 80,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .move(begin: const Offset(0, 0), end: const Offset(30, -10), duration: 7.seconds),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing Logo Container
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF673AB7).withValues(alpha: 0.2),
                        const Color(0xFF673AB7).withValues(alpha: 0),
                      ],
                    ),
                  ),
                  child: Center(
                    child: const AppLogo(size: 110),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds, curve: Curves.easeInOut),

                const SizedBox(height: 40),
                
                // App Name with modern styling
                Text(
                  'BLINDAI',
                  style: GoogleFonts.outfit(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 8,
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),

                const SizedBox(height: 12),
                
                // Tagline with elegant styling
                Text(
                  'Perceive with intelligence',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withValues(alpha: 0.6),
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(delay: 1.seconds, duration: 1.seconds),
              ],
            ),
          ),
          
          // Bottom Loading Indicator (Subtle like Gemini)
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 40,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF673AB7), Color(0xFFFF4081)],
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat())
                 .shimmer(duration: 1.5.seconds),
              ),
            ).animate().fadeIn(delay: 1.5.seconds),
          ),
        ],
      ),
    );
  }
}
