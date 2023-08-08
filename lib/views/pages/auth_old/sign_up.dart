import 'package:booking_system/controller/authController.dart';
import 'package:booking_system/views/share_widgets/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


//enum AuthPageType { login, register }

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
  bool isProgress = false;

  final _formKey = GlobalKey<FormState>();
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

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

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
            appBar: AppBar(
              title: const Text("Register"),
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
                      Text("Register your account",
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
                              isProgress = true;
                              setState(() {});
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                if(!mounted) return;
                                showSnackBar(
                                    context, "You have been registered");
                                
                              } on FirebaseAuthException catch (e) {
                                showSnackBar(context, e.message!);
                              } catch (e) {
                                showSnackBar(context, "from  e.toString()");
                                print(e.toString());
                              }

                              setState(() {
                                isProgress = false;
                              });
                              if(!mounted) return;
                                Navigator.pop(context);

                              // Navigator.pushNamed(context, Routes.login);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.all(16),
                              textStyle: Theme.of(context).textTheme.bodyLarge),
                          child: const Text("Register")),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text("You have an account Login"),
                      )
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
