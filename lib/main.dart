import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env").catchError((_) {});

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BlindAIApp());
}

class BlindAIApp extends StatelessWidget {
  const BlindAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blind AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673AB7),
          primary: const Color(0xFF673AB7),
          secondary: const Color(0xFFFF4081),
          tertiary: const Color(0xFF00BFA5),
        ),
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),
    );
  }
}
