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
      AppAlerts.showError(context, 'Please fill in all fields.');
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
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    } catch (e) {
      if (mounted) AppAlerts.showError(context, 'Login Failed: $e');
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
      body: Stack(
        children: [
          // Colorful Background
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colorScheme.primary, colorScheme.secondary],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Icon(Icons.remove_red_eye_rounded, size: 80, color: Colors.white)
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.easeOutBack)
                      .shimmer(delay: 1.seconds),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 80),
                  
                  // Login Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_rounded,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_rounded,
                          isPassword: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _onResetPassword,
                            child: Text('Forgot Password?', style: TextStyle(color: colorScheme.secondary)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _onLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                              shadowColor: colorScheme.primary.withAlpha(100),
                            ),
                            child: _isLoading 
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ).animate().scale(delay: 400.ms),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 40),
                  
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                        children: [
                          const TextSpan(text: "New here? "),
                          TextSpan(
                            text: 'Create Account',
                            style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms),
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
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
