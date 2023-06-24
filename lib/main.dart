import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_to_text/screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const SplashScreen(),
      theme:ThemeData().copyWith(
        textTheme: GoogleFonts.quicksandTextTheme(const TextTheme())
      )
    );
  }
}