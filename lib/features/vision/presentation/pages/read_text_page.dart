import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../injection_container.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../bloc/vision_bloc.dart';
import '../bloc/vision_event.dart';
import '../bloc/vision_state.dart';

class ReadTextPage extends StatelessWidget {
  const ReadTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VisionBloc>(),
      child: const ReadTextView(),
    );
  }
}

class ReadTextView extends StatelessWidget {
  const ReadTextView({super.key});

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
          'Read Text',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
          const SizedBox(width: 8),
        ],
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is VisionLoading)
                    Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        Text(
                          'Reading text with AI...',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    )
                  else if (state is VisionSuccess)
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        state.result,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          height: 1.5,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ).animate().fadeIn().scale()
                  else
                    _buildInitialState(context, isDark),
                  
                  const SizedBox(height: 48),
                  
                  if (state is! VisionLoading)
                    GestureDetector(
                      onTap: () => context.read<VisionBloc>().add(const CaptureImageRequested(VisionTask.readText)),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF4081), Color(0xFFFF9800)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF4081).withValues(alpha: 0.4),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.document_scanner_rounded, color: Colors.white, size: 32),
                      ).animate(onPlay: (c) => c.repeat())
                       .shimmer(duration: 2.seconds, color: Colors.white24),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialState(BuildContext context, bool isDark) {
    return Column(
      children: [
        Icon(
          Icons.document_scanner_rounded,
          size: 80,
          color: const Color(0xFFFF4081).withValues(alpha: 0.8),
        ).animate(onPlay: (c) => c.repeat(reverse: true))
         .scale(begin: const Offset(1, 1), end: const Offset(1.08, 1.08), duration: 2.seconds),
        const SizedBox(height: 24),
        Text(
          'Text Reader',
          style: GoogleFonts.outfit(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Point your camera at signs, menus, or documents to hear them read aloud.',
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
