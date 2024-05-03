import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muqin/Screens/Sign_in.dart';
import 'package:muqin/Screens/home_page.dart';
import 'package:muqin/Screens/splash_screen.dart';
import 'package:muqin/Widgets/SignInWidgets/error_widget.dart';
import 'package:muqin/firebase_options.dart';
import 'package:muqin/providers/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
  final themeMode = ref.watch(themeModeToggle);
  final isSplashScreenComplete = ref.watch(splashScreenCompleteProvider);
  AsyncValue<User?> authState = ref.watch(authStateProvider);
  Widget screen = const SplashScreen(); // Default to the SplashScreen

    // ignore: avoid_print
    print(themeMode);
    if (isSplashScreenComplete) {
      // If the splash screen timer is complete, decide based on auth state
      screen = authState.when(
        data: (User? user) => user == null ? SignInPage(ref) : const HomePage(),
        loading: () => const SplashScreen(), // Keep showing the splash screen if auth state is loading
        error: (error, stack) => ErrorScreen(error: error),
      );
    }
    return MaterialApp(
      title: 'موقن',
      theme: Theme.of(context).copyWith(
       brightness: Brightness.light,
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
      themeMode: themeMode,
      darkTheme: Theme.of(context).copyWith(
        brightness: Brightness.dark,
        
        textTheme: GoogleFonts.notoSansArabicTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(0, 1, 1, 1)
        ),
        
        buttonTheme: ButtonThemeData(
          buttonColor: const Color.fromARGB(255, 222, 119, 115),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 222, 119, 115)
          )
        )
      ),
      
      home: screen
    );
  }
}


