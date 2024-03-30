import 'package:flutter/material.dart';

// ignore: camel_case_types
class greetingSection extends StatelessWidget {
  const greetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "تسجيل الدخول",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "مرحبًا بعودتك",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                );
  }
}