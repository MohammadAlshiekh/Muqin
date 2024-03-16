import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muqin/Screens/Sign_in.dart';
import 'package:muqin/Widgets/SignInWidgets/email_field.dart';
import 'package:muqin/Widgets/SignInWidgets/password_field.dart';
import 'package:muqin/services/auth_services.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final  _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _vpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool showClearIcon = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _vpasswordController.dispose();
    super.dispose();
  }
    Future signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        user.user!.updateDisplayName(_nameController.text.trim());
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SignInPage(ref)),
          );
        }
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
                  flex: 1,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "سجل حساب جديد",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "سجل لتستكشف جميع الكتب الموجودة",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: 350,
        child: Card(
          elevation: 5,
          child: TextFormField(
            obscureText: true,
            validator: (value) {
              return null;
            },
            controller: _nameController,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 236, 236, 236),
              filled: true,
              hintText: "الاسم الكامل",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: EmailField(emailController: _emailController)
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: PasswordField(passwordController: _passwordController)
                      ),
                      const SizedBox(height: 10),
                     Directionality(
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
              else if(value.trim() != _passwordController.text.trim()) {
                return 'كلمة المرور غير متطابقة';
              }
              return null;
            },
            controller: _vpasswordController,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 236, 236, 236),
              filled: true,
              hintText: "تأكيد كلمة المرور",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ),
                      const SizedBox(height: 32.0),
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
                          onPressed: signUp,
                          child: Text(
                            "سجل",
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
                            MaterialPageRoute(builder: (context) =>  SignInPage(ref)),
                          )
                        },
                        child: Text(
                          ".عندك حساب من قبل؟ سجل الدخول",
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
                const Spacer(),
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
                          onPressed: AuthService().signInWithGoogle,
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
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

bool isValidPassword(String password) {
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z]).{8,}$',
  );
  return passwordRegExp.hasMatch(password);
}
