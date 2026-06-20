import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../auth/services/auth_service.dart';
import '../auth/screens/login_screen.dart';
import '../chat/screens/chat_screen.dart';

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

  void _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;

    final authService = AuthService();
    final bool isLoggedIn = authService.currentUser != null;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
            isLoggedIn ? const ChatScreen() : const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer,
              colorScheme.surface,
              colorScheme.secondaryContainer.withAlpha(127),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dynamic Animated Logo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: const Duration(seconds: 2), curve: Curves.easeInOut),
                
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withAlpha(102),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.remove_red_eye_rounded, color: Colors.white, size: 40),
                )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 800))
                .scale(delay: const Duration(milliseconds: 200), curve: Curves.elasticOut),
              ],
            ),
            
            const SizedBox(height: 40),
            
            Text(
              'Blind AI',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: colorScheme.onSurface,
                letterSpacing: -1,
              ),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 400), duration: const Duration(milliseconds: 800))
            .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack),
            
            const SizedBox(height: 8),
            
            Text(
              'Your Visionary Companion',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface.withAlpha(153),
                fontWeight: FontWeight.w500,
              ),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 600))
            .scale(delay: const Duration(milliseconds: 600)),
            
            const SizedBox(height: 100),
            
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 1000)),
          ],
        ),
      ),
    );
  }
}
