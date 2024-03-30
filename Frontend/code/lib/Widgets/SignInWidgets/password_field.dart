import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.passwordController});
  final TextEditingController passwordController;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: 350,
        child: Card(
          elevation: 5,
          child: TextFormField(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل الرقم السري من فضلك';
              }
              return null;
            },
            controller: widget.passwordController,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 236, 236, 236),
              filled: true,
              hintText: "كلمة المرور",
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
