import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muqin/Screens/Sign_in.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final  _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showClearIcon = false;

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: Card(
                        elevation: 5,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 236, 236, 236),
                            filled: true,
                            hintText: "البريد الالكتروني",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: showClearIcon
                                ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.red[900],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _emailController.clear();
                                        showClearIcon = false;
                                      });
                                    },
                                  )
                                : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              showClearIcon = value.isNotEmpty;
                            });
                            bool isValid = isValidEmail(value);
                            if (isValid) {
                              setState(() {
                                showClearIcon = value.isEmpty;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: Card(
                        elevation: 5,
                        child: TextField(
                          controller: _passwordController,
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
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: Card(
                        elevation: 5,
                        child: TextField(
                          controller: _passwordController,
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
                        onPressed: () {
                          // Perform signup logic here
                        },
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
                          onPressed: () {},
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

bool isValidEmail(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );
  return emailRegExp.hasMatch(email);
}

bool isValidPassword(String password) {
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z]).{8,}$',
  );
  return passwordRegExp.hasMatch(password);
}
