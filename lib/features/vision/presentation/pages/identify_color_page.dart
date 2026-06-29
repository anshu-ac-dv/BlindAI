import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../injection_container.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../bloc/vision_bloc.dart';
import '../bloc/vision_event.dart';
import '../bloc/vision_state.dart';

class IdentifyColorPage extends StatelessWidget {
  const IdentifyColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VisionBloc>(),
      child: const IdentifyColorView(),
    );
  }
}

class IdentifyColorView extends StatelessWidget {
  const IdentifyColorView({super.key});

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
          'Identify Color',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
      body: BlocConsumer<VisionBloc, VisionState>(
        listener: (context, state) {
          if (state is VisionError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is VisionLoading)
                  const CircularProgressIndicator()
                else if (state is VisionSuccess)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      state.result,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  )
                else
                  _buildInitialState(isDark),
                
                const SizedBox(height: 60),
                
                if (state is! VisionLoading)
                  GestureDetector(
                    onTap: () => context.read<VisionBloc>().add(CaptureImageRequested()),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00BCD4), Color(0xFF4CAF50)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00BCD4).withValues(alpha: 0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.colorize_rounded, color: Colors.white, size: 32),
                    ).animate(onPlay: (c) => c.repeat())
                     .shimmer(duration: 2.seconds, color: Colors.white24),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialState(bool isDark) {
    return Column(
      children: [
        Icon(
          Icons.palette_outlined,
          size: 80,
          color: const Color(0xFF00BCD4).withValues(alpha: 0.5),
        ).animate(onPlay: (c) => c.repeat(reverse: true))
         .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds),
        const SizedBox(height: 24),
        Text(
          'Color Identifier',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Focus the camera on an object to identify its exact color.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
