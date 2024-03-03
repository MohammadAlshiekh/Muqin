import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muqin/Screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muqin',
      theme: Theme.of(context).copyWith(
        textTheme: GoogleFonts.notoSansArabicTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 23, 27, 54)
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color.fromARGB(255, 222, 119, 115),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 222, 119, 115)
          )
        )
      ),
      home: const SplashScreen(), // Set SplashScreen as the home page
    );
  }
}

