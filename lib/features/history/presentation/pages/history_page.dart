import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
          'Activity History',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_rounded,
              size: 64,
              color: isDark ? Colors.white10 : Colors.black12,
            ),
            const SizedBox(height: 16),
            Text(
              'No history yet',
              style: GoogleFonts.outfit(
                fontSize: 18,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
