import 'package:booking_system/controller/authController.dart';
import 'package:booking_system/views/share_widgets/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../utilities/routes.dart';


enum AuthPageType { login, register }

class MyLogIn extends StatefulWidget {
  const MyLogIn({super.key});

  @override
  State<MyLogIn> createState() => _MyLogInState();
}
// applaying media query

class _MyLogInState extends State<MyLogIn> {
  bool _obscureText = true;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isProgress = false;

  // var authPageType = AuthPageType.login;
  signIn(AuthController authController) async {
    try {
      await authController.signIn();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No user found for that email")));
      }
    }
  }

  signUp(AuthController authController) async {
    try {
      await authController.signUp();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;

    final emailFormFeild = TextFormField(
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return "you should enter your email";
        }
        return null;
      },
      onChanged: (value) => email = value,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordFormField = TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return "you should enter your name";
        } else {
          return null;
        }
      },
      onChanged: (value) => password = value,
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: _obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        labelText: "Password",
        hintText: "Enter your password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // final nameFormField = TextFormField(
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return "you should enter your name";
    //     }
    //   },
    //   decoration: InputDecoration(
    //     labelText: "Name",
    //     hintText: "Enter your name",
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // );

    return Consumer<AuthController>(builder: (context, authController, child) {
      return SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isProgress,
          child: Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.login)),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.loginHere,
                          style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(
                        height: 16,
                      ),
                      emailFormFeild,
                      const SizedBox(
                        height: 10,
                      ),
                      passwordFormField,
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            // validate the form before submitting
                            if (_formKey.currentState!.validate()) {
                              print(
                                  "my email is ${email} and password is: ${password} ");

                              try {
                                setState(() {
                                  isProgress = true;
                                });
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (!mounted) return;
                                Navigator.pushNamed(context, Routes.chatPage);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showSnackBar(
                                      context, 'No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  showSnackBar(context,
                                      'Wrong password provided for that user.');
                                } else {
                                  showSnackBar(context, e.message!);
                                }
                              } catch (e) {
                                showSnackBar(context, "from catch $e");
                              }
                              setState(() {
                                isProgress = false;
                              });
                              // try {
                              //   setState(() {
                              //     isProgress = true;
                              //   });
                              //   UserCredential userCredential =
                              //       await FirebaseAuth.instance
                              //           .signInWithEmailAndPassword(
                              //               email: email, password: password);
                              // } on FirebaseAuthException catch (e) {
                              //   print(e);
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content: Text(e.message!),
                              //           duration: const Duration(seconds: 10)));

                              //   //Navigator.pushNamed(context, Routes.home);

                              // } catch (e) {
                              //   print(e);
                              // }

                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.all(16),
                              textStyle: Theme.of(context).textTheme.bodyLarge),
                          child:  Text(AppLocalizations.of(context)!.login)),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, Routes.signUp);
                          },
                          child:
                              const Text("You don't have an account Register"))
                    ],
                  ),
                ),
              )),
            ),
          ),
        ),
      );
    });
  }
}
