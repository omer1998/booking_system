import 'package:booking_system/views/pages/auth/patient_page/sign_in/p_sign_in_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientSignInPage extends StatefulWidget {
  const PatientSignInPage({super.key});

  @override
  State<PatientSignInPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PatientSignInPage> {
    final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 150.h,
                // ),
                FlutterLogo(
                  size: 60.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Sign In',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Consumer(builder: (context, WidgetRef ref, _) {
                  return Form(
                    key: formKey,
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          onChanged: (value) {
                            ref
                                .read(patientSignInNotifierProvider.notifier)
                                .setEmail(value.trim());
                          },
                          autocorrect: true,
                          enableSuggestions: true,
                          keyboardType: TextInputType.emailAddress,
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
                            if (!value.contains(".com")) {
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
                              .read(patientSignInNotifierProvider)
                              .passwordObscure,
                          onChanged: (value) {
                            ref
                                .read(patientSignInNotifierProvider.notifier)
                                .setPassword(value.trim());

                            print(ref
                                .read(patientSignInNotifierProvider)
                                .password);
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
                                      .read(patientSignInNotifierProvider
                                          .notifier)
                                      .togglePasswordObscure();
                                },
                                icon: Icon(ref
                                        .watch(patientSignInNotifierProvider)
                                        .passwordObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 45.0,
                        width: 180.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                          ),
                          child: Text('sign In'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              )),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(patientSignInNotifierProvider.notifier)
                                  .signIn(context);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do not have an account,"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Sign Up"))
                        ],
                      ),
                    ],
                  ));
                }),

                // RichText(text:TextSpan(
                //   children: [
                //     TextSpan(text: "Do not have an account, "),
                //     TextButton(onPressed: (){}, child: Text("kfifjwei"))

                //   ]
                // ) )
              ]),
        ),
      ),
    );
  }
}
