import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/app_alerts.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
import '../../chat/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  void _onLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppAlerts.showError(context, 'Please fill in all fields to log in.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signIn(email, password);
      if (!mounted) return;
      
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ChatScreen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    } catch (e) {
      if (mounted) {
        AppAlerts.showError(context, 'Login Failed: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onResetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppAlerts.showError(context, 'Please enter your email to receive a reset link.');
      return;
    }

    try {
      await _authService.sendPasswordResetEmail(email);
      if (mounted) {
        AppAlerts.showSuccess(context, 'A password reset link has been sent to your email.');
      }
    } catch (e) {
      if (mounted) {
        AppAlerts.showError(context, 'Reset Failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Background Decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha(12),
                shape: BoxShape.circle,
              ),
            ).animate().scale(duration: const Duration(seconds: 2), curve: Curves.easeInOut),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: colorScheme.onSurface,
                      letterSpacing: -1,
                    ),
                  ).animate().fadeIn(duration: const Duration(milliseconds: 600)).slideX(begin: -0.2, end: 0),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    'Log in to continue your journey.',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurface.withAlpha(153),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
                  
                  const SizedBox(height: 60),
                  
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                  ).animate().fadeIn(delay: const Duration(milliseconds: 400)).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ).animate().fadeIn(delay: const Duration(milliseconds: 500)).slideY(begin: 0.1, end: 0),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _onResetPassword,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
                  
                  const SizedBox(height: 30),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 700)).scale(begin: const Offset(0.95, 0.95)),
                  
                  const SizedBox(height: 24),
                  
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: colorScheme.onSurface.withAlpha(153), fontSize: 16),
                          children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 900)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outline.withAlpha(25)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: colorScheme.primary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
