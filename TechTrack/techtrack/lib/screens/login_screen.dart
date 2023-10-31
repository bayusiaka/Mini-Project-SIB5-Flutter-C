import 'package:flutter/material.dart';
import 'package:techtrack/screens/signup_screen.dart';
import 'package:techtrack/models/user_model.dart';
import 'package:techtrack/helper/database_helper.dart';
import 'package:techtrack/screens/home_screen.dart';
import 'package:techtrack/providers/authentication_service.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final db = DatabaseHelper();

  bool isVisible = false;
  bool isLoginTrue = false;

  final formKey = GlobalKey<FormState>();

  void login(AuthenticationService authService) async {
    var response = await db
        .login(UserModel(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      if (!mounted) return;
      authService
          .login(UserModel(usrName: username.text, usrPassword: password.text));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username.text),
        ),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Consumer<AuthenticationService>(
                builder: (context, authService, child) {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/welcome.png',
                        width: 250,
                        height: 250,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 238, 248, 255),
                        ),
                        child: TextFormField(
                          cursorColor: const Color.fromRGBO(67, 176, 255, 1),
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(202, 82, 79, 79),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 238, 248, 255),
                        ),
                        child: TextFormField(
                          cursorColor: const Color.fromRGBO(67, 176, 255, 1),
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(202, 82, 79, 79),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(67, 176, 255, 1),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              login(authService);
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Color.fromRGBO(67, 176, 255, 1)),
                            ),
                          ),
                        ],
                      ),
                      if (isLoginTrue)
                        const Text(
                          "User doesn't exist!",
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        const SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
