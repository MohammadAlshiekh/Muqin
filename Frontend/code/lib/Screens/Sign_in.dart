// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:muqin/Screens/Sign_up.dart';
import 'package:muqin/Widgets/SignInWidgets/email_field.dart';
import 'package:muqin/Widgets/SignInWidgets/greeting_section.dart';
import 'package:muqin/Widgets/SignInWidgets/password_field.dart';
import 'package:muqin/providers/provider.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage(this.ref, {super.key});
  final WidgetRef ref;

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showClearIcon = false;
  late GoogleSignInAccount currentUser;
  var _googleSignIn;
  @override
  void initState() {
    _googleSignIn = widget.ref.read(googleSignIn);
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        currentUser = account!;
        if (currentUser != null) {
          print(currentUser);
        }
      });
      _googleSignIn.signInSilently();
    });
    super.initState();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'خطأ',
              textDirection: TextDirection.rtl,
            ),
          ),
        );
      }
    }
  }

  Future<void> googleSignOut() async {
    await _googleSignIn.signOut();
  }

  Future singIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تأكد من البريد الإلكتروني وكلمة السر.',
                textDirection: TextDirection.rtl,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/log_shape.svg",
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                const greetingSection(),
                const Spacer(flex: 1),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EmailField(emailController: _emailController),
                      const SizedBox(height: 10),
                      PasswordField(passwordController: _passwordController),
                      const SizedBox(height: 14),
                      Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Text(
                            "نسيت كلمة السر؟",
                            style: GoogleFonts.vazirmatn(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: const Color.fromARGB(255, 41, 43, 56)),
                          )),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 222, 119, 115),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: singIn,
                          child: Text(
                            "سجل الدخول",
                            style: GoogleFonts.vazirmatn(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          )
                        },
                        child: Text(
                          "سجل بحساب جديد",
                          style: GoogleFonts.vazirmatn(
                              textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 110, 110, 110),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Column(
                  children: [
                    const Text("أو كمل بالطرق التالية"),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              surfaceTintColor:
                                  const Color.fromARGB(255, 236, 236, 236),
                              backgroundColor:
                                  const Color.fromARGB(255, 236, 236, 236),
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: signInWithGoogle,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
