import 'package:muqin/Book.dart';
import 'package:muqin/Sign_in.dart';
import 'package:muqin/Sign_up.dart';
import 'package:muqin/home_page.dart';
import 'package:muqin/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muqin Prototype',
      theme: Theme.of(context).copyWith(
          textTheme:
              GoogleFonts.notoSansArabicTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 23, 27, 54)),
          buttonTheme: ButtonThemeData(
              buttonColor: const Color.fromARGB(255, 222, 119, 115),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 222, 119, 115)))),
      home: CatalogPage(),
    );
  }
}
