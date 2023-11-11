import 'package:fitness/firebase/email_auth.dart';
import 'package:fitness/firebase/facebook_auth.dart';
import 'package:fitness/firebase/github_auth.dart';
import 'package:fitness/firebase/google_auth.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController resPwdEmail = TextEditingController();
  TextEditingController confirmResPwdEmail = TextEditingController();

  final emailAuth = EmailAuth();
  final gitAuth = GithubAuth();
  final googleAuth = GoogleAuth();
  final facebookAuth = Facebook();

  @override
  Widget build(BuildContext context) {
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
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "Password"),
                    controller: pwdController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: CheckboxListTile(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          title: const Text(
                            "Remember me",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      //Expanded(child: Container()),
                      TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Write and confirm your email address'),
                                  content: SizedBox(
                                    height: 110,
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                              suffixIcon:
                                                  provider.emailConfirmedPwd
                                                      ? const Icon(
                                                          Icons
                                                              .check_circle_outline_outlined,
                                                          color: Colors.green,
                                                        )
                                                      : null,
                                              hintText: "Email"),
                                          controller: resPwdEmail,
                                          onChanged: (value) {
                                            if (resPwdEmail.text.isNotEmpty &&
                                                confirmResPwdEmail
                                                    .text.isNotEmpty) {
                                              if (resPwdEmail.text ==
                                                  confirmResPwdEmail.text) {
                                                provider.emailConfirmedPwd =
                                                    true;
                                              } else {
                                                provider.emailConfirmedPwd =
                                                    false;
                                              }
                                            }
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                              suffixIcon:
                                                  provider.emailConfirmedPwd
                                                      ? const Icon(
                                                          Icons
                                                              .check_circle_outline_outlined,
                                                          color: Colors.green,
                                                        )
                                                      : null,
                                              hintText: "Confirm Email"),
                                          controller: confirmResPwdEmail,
                                          onChanged: (value) {
                                            if (resPwdEmail.text.isNotEmpty &&
                                                confirmResPwdEmail
                                                    .text.isNotEmpty) {
                                              if (resPwdEmail.text ==
                                                  confirmResPwdEmail.text) {
                                                provider.emailConfirmedPwd =
                                                    true;
                                              } else {
                                                provider.emailConfirmedPwd =
                                                    false;
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (provider.emailConfirmedPwd) {
                                          emailAuth
                                              .resetPassword(resPwdEmail.text);
                                          resPwdEmail.text = "";
                                          confirmResPwdEmail.text = "";
                                          Navigator.of(context).pop();
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Error"),
                                                  content: const Text(
                                                      "The emails not match"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Close"))
                                                  ],
                                                );
                                              });
                                        }
                                      },
                                      child: const Text('Send'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text("Forgot password?"))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool res = await emailAuth.validateUser(
                            email: emailController.text,
                            pwd: pwdController.text);
                        if (res) {
                          Navigator.pushNamed(context, '/dashboard');
                        } else {
                          print("Credenciales No Invalidas");
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(400, 50))),
                      child: const Text("LOGIN")),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("- OR -"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Log In with"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(50, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                          onPressed: () async {
                            try {
                              var user =
                                  await facebookAuth.signInWithFacebook();
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashboardScreen(
                                              user: user,
                                            )));
                              } else {
                                print("Inicio de sesion cancelado");
                              }
                            } catch (e) {
                              print('Error al iniciar sesion: $e');
                            }
                          },
                          child: Image.asset(
                            'assets/images/facebook.png',
                            width: 23,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(50, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                          onPressed: () async {
                            try {
                              var user = await googleAuth.signInWithGoogle();
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashboardScreen(
                                              user: user,
                                            )));
                              } else {
                                print("Inicio de sesion cancelado");
                              }
                            } catch (e) {
                              print('Error al iniciar sesion: $e');
                            }
                          },
                          child: Image.asset(
                            'assets/images/google.png',
                            width: 23,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(50, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                          onPressed: () async {
                            /* final user = await gitAuth.signInWithGitHub();
                            if (user != null) {
                              Navigator.pushNamed(context, '/dashboard');
                            } else {
                              print("Credenciales git invalidas");
                            } */
                          },
                          child: Image.asset(
                            'assets/images/github.png',
                            width: 23,
                          )),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
