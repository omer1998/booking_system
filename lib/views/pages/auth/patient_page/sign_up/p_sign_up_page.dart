import 'dart:convert';
import 'package:booking_system/utilities/routes.dart';
import 'package:booking_system/views/pages/auth/patient_page/sign_up/p_sign_up_controller.dart';
import 'package:booking_system/views/pages/auth/patient_page/patients_auth_widgets.dart';
import 'package:booking_system/views/share_widgets/show_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utilities/providers.dart';
import '../../../../share_widgets/show_snackbar.dart';

class PatientSignUpPage extends StatefulWidget {
  const PatientSignUpPage({super.key});

  @override
  State<PatientSignUpPage> createState() => PatientSignUpStatePage();
}

class PatientSignUpStatePage extends State<PatientSignUpPage> {
  @override
  Widget build(BuildContext context) {
    // var state = ref.watch(patientSignupControllerProvider);
    // TextEditingController emailController = TextEditingController();
    // AuthController controller = ref.watch(authControllerProvider);

    // TextEditingController passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              FlutterLogo(
                size: 60.w,
              ),
              SizedBox(height: 20.h),
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Form(
                key: formKey,
                child: Consumer(builder: (context, ref, _) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //     label: Text("First Name"),
                        //     hintText: "Enter your full Name",
                        //     border: OutlineInputBorder()

                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your first name';
                        //     }
                        //     return null;
                        //   },
                        //   onChanged: (value) {

                        //   },
                        // )
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            initialValue:
                                ref.read(authControllerProvider).firstName,
                            onChanged: (value) {
                              ref
                                  .read(authControllerProvider)
                                  .setFirstName(value.trim());
                              print(ref.read(authControllerProvider).firstName);

                              // ref
                              //     .read(authControllerProvider.notifier)
                              //     .setFirstName(value);
                              // print("first name: $controller.firstName");
                            },
                            autocorrect: true,
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {},
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              hintStyle: TextStyle(color: Colors.black54),
                              icon: Icon(Icons.email_outlined,
                                  color: Colors.blue.shade700, size: 24),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            // controller: _email,
                            initialValue:
                                ref.read(authControllerProvider).lastName,
                            onChanged: (value) {
                              ref
                                  .read(authControllerProvider)
                                  .setLastName(value.trim());
                              print(ref.read(authControllerProvider).lastName);

                              // ref
                              //     .read(authControllerProvider.notifier)
                              //     .setPassword(value);
                              // print(controller.password);
                            },
                            autocorrect: true,
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {},
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: TextStyle(color: Colors.black54),
                              icon: Icon(Icons.email_outlined,
                                  color: Colors.blue.shade700, size: 24),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            // controller: emailController,
                            initialValue:
                                ref.read(authControllerProvider).email,
                            onChanged: (value) {
                              // email = value.trim();
                              // controller.setEmail(value);
                              ref.read(authControllerProvider).setEmail(value);
                              print(ref.read(authControllerProvider).email);

                              // controller.email;
                              // ref.read(authControllerProvider.notifier).setEmail(value.trim() );
                              print(
                                  "-->  ${ref.read(authControllerProvider).email}");
                              print("--> $value");
                            },
                            autocorrect: true,
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              // ref.read(authControllerProvider).setEmail(value!);
                              // print(ref.read(authControllerProvider).)
                            },
                            decoration: InputDecoration(
                              hintText: 'Email address',
                              hintStyle: TextStyle(color: Colors.black54),
                              icon: Icon(Icons.email_outlined,
                                  color: Colors.blue.shade700, size: 24),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "required";
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            // controller: passwordController,
                            // initialValue: controller.password,
                            obscureText: ref
                                .watch(authControllerProvider)
                                .passwordObscure,
                            onChanged: (value) {
                              // password = value.trim();
                              ref
                                  .read(authControllerProvider)
                                  .setpassword(value);
                              print(ref.read(authControllerProvider).password);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "required";
                              }
                              if (value.length < 8) {
                                return 'Password is required, 8 characters!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.black54),
                                icon: Icon(CupertinoIcons.lock_circle,
                                    color: Colors.blue.shade700, size: 24),
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ref
                                        .read(authControllerProvider)
                                        .togglePasswordObscure();
                                  },
                                  icon: Icon(ref
                                          .watch(authControllerProvider)
                                          .passwordObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                          ),
                        ),
                        // SizedBox(height: 10.0),

                        // Container(
                        //   margin: const EdgeInsets.symmetric(
                        //       horizontal: 24, vertical: 8),
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 16, vertical: 4),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(25)),
                        //   child: TextFormField(
                        //       // controller: passwordController,
                        //       controller: ref
                        //           .read(authControllerProvider)
                        //           .sexFieldController,
                        //       readOnly: true,
                        //       // initialValue: ref.watch(authControllerProvider).sex.toString().split(".")[1],
                        //       validator: (value) {
                        //         if (value!.isEmpty) {
                        //           return "required";
                        //         }

                        //         return null;
                        //       },
                        //       decoration: InputDecoration(
                        //         hintText: 'Sex',
                        //         hintStyle: TextStyle(color: Colors.black54),
                        //         icon: Icon(CupertinoIcons.lock_circle,
                        //             color: Colors.blue.shade700, size: 24),
                        //         alignLabelWithHint: true,
                        //         border: InputBorder.none,
                        //         // suffixIcon: IconButton(
                        //         //   onPressed: () {
                        //         //     ref.read(authControllerProvider).togglePasswordObscure();
                        //         //   },
                        //         //   icon: Icon(ref.watch(authControllerProvider).passwordObscure
                        //         //       ? Icons.visibility
                        //         //       : Icons.visibility_off),
                        //         // )
                        //       ),
                        //       onTap: () {
                        //         showModalBottomSheet(
                        //             isDismissible: false,
                        //             context: context,
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.only(
                        //                     topLeft: Radius.circular(20.w),
                        //                     topRight: Radius.circular(20.w))),
                        //             builder: (context) {
                        //               return SizedBox(
                        //                   height: 200.h,
                        //                   child: const PatientSexRadioButton());
                        //             });
                        //       }),
                        // ),

                        SizedBox(
                          height: 15.h,
                        ),
                        ref.watch(authControllerProvider).isLoading
                            ? CircularProgressIndicator()
                            : Container(
                                height: 45.0,
                                width: 180.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                  child: Text('sign up'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      await ref
                                          .read(authControllerProvider.notifier)
                                          .signUp(context);
                                    }
                                  },
                                ),
                              ),
                      ]);
                }),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.patientSignIn);
                      },
                      child: Text("Sign In"))
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
