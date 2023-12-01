import 'package:fitness/firebase/email_auth.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool flag = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailAuth = EmailAuth();
    var provider = Provider.of<ProviderModel>(context);
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
              provider.registerMessage != ""
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(224, 71, 71, 0.875)),
                      child: Center(
                        child: Text(
                          provider.registerMessage,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(),
              provider.registerMessage != ""
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(children: [
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person), hintText: "Name"),
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                                Icons.check_circle_outline_outlined,
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
                                Icons.check_circle_outline_outlined,
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
                        if (pwdController.text != "" &&
                            confirmPwdController.text != "") {
                          if (pwdController.text == confirmPwdController.text) {
                            flag = true;
                          } else {
                            flag = false;
                          }
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
                        if (emailController.text != "") {
                          if (flag) {
                            if (pwdController.text.length > 9) {
                              if (nameController.text.isNotEmpty) {
                                if (pwdController.text ==
                                    confirmPwdController.text) {
                                  emailAuth.createUser(
                                      name: nameController.text,
                                      email: emailController.text,
                                      pwd: pwdController.text);
                                  provider.registerMessage = "";
                                  Navigator.pop(context);
                                } else {
                                  provider.registerMessage =
                                      "Passwords not match, try again";
                                }
                              } else {
                                provider.registerMessage =
                                    "Name field must not be empty";
                              }
                            } else {
                              provider.registerMessage =
                                  "Password must be at least 10 characters";
                            }
                          } else {
                            provider.registerMessage =
                                "Passwords are empty or not match";
                          }
                        } else {
                          provider.registerMessage =
                              "The email field must not be empty";
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(400, 50))),
                      child: Text("REGISTER",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
