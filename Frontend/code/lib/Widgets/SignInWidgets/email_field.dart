import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: 350,
        child: Card(
          elevation: 5,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل البريد الإلكتروني من فضلك';
              } else if (!isValidEmail(widget.emailController.text.trim())) {
                return 'أدخل بريد إلكتروني صحيح من فضلك';
              }
              return null;
            },
            controller: widget.emailController,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 236, 236, 236),
              filled: true,
              hintText: "البريد الالكتروني",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
