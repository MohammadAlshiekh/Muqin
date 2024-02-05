import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 60,
                  child: Card(
                    elevation: 5,
                    child: TextField(
                      controller: _usernameController,
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
                const SizedBox(height: 32.0),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 222, 119, 115),
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
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                const Text(".عندك حساب من قبل؟ سجل الدخول"),
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
    );
  }
}
