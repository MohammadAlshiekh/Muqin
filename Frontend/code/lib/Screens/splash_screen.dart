import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/providers/provider.dart';



class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start the timer when the widget is first built
    Future.delayed(const Duration(seconds: 2), () {
      // After 3 seconds, update the splashScreenCompleteProvider to true
      ref.read(splashScreenCompleteProvider.notifier).state = true;
    });

    return Container(
      // Your splash screen content here
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Splash.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
