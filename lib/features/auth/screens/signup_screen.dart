import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/app_alerts.dart';
import '../services/auth_service.dart';
import '../../chat/screens/chat_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  void _onSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppAlerts.showError(context, 'Please fill in all fields.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signUp(email, password);
      if (!mounted) return;
      
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ChatScreen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 800),
        ),
        (route) => false,
      );
    } catch (e) {
      if (mounted) AppAlerts.showError(context, 'Signup Failed: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colorScheme.secondary, colorScheme.tertiary],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 80),
                  
                  // Signup Card
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
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _onSignup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.secondary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                              shadowColor: colorScheme.secondary.withAlpha(100),
                            ),
                            child: _isLoading 
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('SIGN UP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ).animate().scale(delay: 400.ms),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 40),
                  
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                        children: [
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: colorScheme.secondary, fontWeight: FontWeight.bold),
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
        prefixIcon: Icon(icon, color: colorScheme.secondary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colorScheme.secondary, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
