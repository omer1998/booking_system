import 'package:booking_system/controller/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


enum AuthPageType { login, register }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
// applaying media query

class _LoginState extends State<Login> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  // var authPageType = AuthPageType.login;
  signIn(AuthController authController) async {
    try {
      await authController.signIn();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
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
    final emailFormFeild = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "you should enter your email";
        }
        return null;
      },
      onChanged: (value) => context.read<AuthController>().setEmail(value),
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordFormField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "you should enter your name";
        } else {
          return null;
        }
      },
      onChanged: (value) => context.read<AuthController>().setPassword(value),
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

    final nameFormField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "you should enter your name";
        }
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return Consumer<AuthController>(builder: (context, authController, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: authController.pageAuthType == AuthPageType.login
                ? Text(AppLocalizations.of(context)!.login)
                : const Text("Register"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Login here",
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
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              // validate the form before submitting
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (authController.pageAuthType ==
                                    AuthPageType.login) {
                                  signIn(authController);
                                } else {
                                  signUp(authController);
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.all(16),
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge),
                            child: authController.pageAuthType ==
                                    AuthPageType.login
                                ? const Text("Login")
                                : const Text("Register")),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        authController.changePageAuthType();
                      },
                      child: authController.pageAuthType == AuthPageType.login
                          ? const Text("You don't have an account Register")
                          : const Text("You have an account Login"),
                    )
                  ],
                ),
              ),
            )),
          ),
        ),
      );
    });
  }
}
