import 'package:fitness/firebase/email_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool flag = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailAuth = EmailAuth();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/mainLogo.png',
                width: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Register",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(children: [
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email"),
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: flag == true
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                        hintText: "Password"),
                    controller: pwdController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        if (pwdController.text == confirmPwdController.text &&
                            (pwdController.text.isNotEmpty &&
                                confirmPwdController.text.isNotEmpty)) {
                          flag = true;
                        } else {
                          flag = false;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: flag == true
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                        hintText: "Confirm Password"),
                    controller: confirmPwdController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        if (pwdController.text == confirmPwdController.text) {
                          flag = true;
                        } else {
                          flag = false;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (pwdController.text == confirmPwdController.text) {
                          emailAuth.createUser(
                              email: emailController.text,
                              pwd: pwdController.text);
                          Navigator.pop(context);
                        } else {
                          print(
                              "Las contraseñas no coinciden, intentalo de nuevo");
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(400, 50))),
                      child: const Text("REGISTER")),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
