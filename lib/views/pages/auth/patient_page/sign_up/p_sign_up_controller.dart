// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:booking_system/models/api/response.dart';
import 'package:booking_system/repositories/patient_repository_remote.dart';
import 'package:booking_system/utilities/constants.dart';
import 'package:booking_system/utilities/handle_response.dart';
import 'package:booking_system/views/share_widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:http/http.dart' as http;

import '../../../../../utilities/routes.dart';
import '../../../../share_widgets/show_dialogue.dart';

// part "patient_signup_controller.g.dart";

// class PatientSignupController
//     extends StateNotifier<PatientSignupState> {
//   PatientAuthRepository patientAuthRepository = PatientAuthRepository();

//   PatientSignupController()
//       : super(PatientSignupState(" ", " ", " ", " ")) {}

// }

// class PatientSignupState {
//   final String firstName;
//   final String lastName;
//   final String password;
//   final String email;

//   PatientSignupState(this.firstName, this.lastName, this.password, this.email);

//   PatientSignupState copyWith({
//     String? firstName,
//     String? lastName,
//     String? password,
//     String? email,
//   }) {
//     return PatientSignupState(
//       firstName ?? this.firstName,
//       lastName ?? this.lastName,
//       password ?? this.password,
//       email ?? this.email,
//     );
//   }
// }

// class AuthController {
//   PatientAuthRepository patientAuthRepository = PatientAuthRepository();
//   String? firstName, lastName, password, email;
//   PatientSignup patientSignupInfo = PatientSignup(firstName: "", lastName: "", email: "", password: "");
//   bool passwordObscure = true;
//   bool loading = false;

//   Future patientSignIn() {
//     if (email != " " && password != " ") {
//       Future.delayed(Duration(seconds: 5));
//       return Future.value("you successfuly sign in ");
//     } else {
//       return Future.value(" name and password are required");
//     }
//   }
// }

// final patientSigninProvider =
//     FutureProvider((ref) => ref.read(authControllerProvider).patientSignIn());
// final authControllerProvider =
//     StateProvider.autoDispose((ref) => AuthController());

// @riverpod
// PatientSignupController patientSignupController(PatientSignupControllerRef ref) {
//   return PatientSignupController("","","","");
// }

// class AuthController extends StateNotifier<PatientAuthState> {
//   PatientAuthRepository patientAuthRepository = PatientAuthRepository();

//   AuthController() : super(PatientAuthState());

//   void setFirstName(String firstName) {
//     state = state.copyWith(firstName: firstName);
//   }

//   void setLastName(String lastName) {
//     state = state.copyWith(lastName: lastName);
//   }

//   void setPassword(String password) {
//     state = state.copyWith(password: password);
//   }

//   void setEmail(String email) {
//     state = state.copyWith(email: email);
//   }
//   void togglePassword(bool passwordObscure){
//     state = state.copyWith(passwordObscure: passwordObscure);
//   }
//   void changeLoading(bool loading){
//     state = state.copyWith(loading: loading);

//   }

//   Future<void> patientSignIn() async {
//     if (state.email.isNotEmpty && state.password.isNotEmpty) {
//       try {
//         state = state.copyWith(loading: true);

//         // Perform the sign-in operation using the patientAuthRepository
//         // You can access the state fields using state.email and state.password.

//         // Simulating a delayed sign-in for demonstration purposes.
//         await Future.delayed(Duration(seconds: 2));

//         // Handle successful sign-in
//         state = state.copyWith(loading: false, successMessage: "You successfully signed in");
//       } catch (e) {
//         // Handle sign-in failure
//         state = state.copyWith(loading: false, errorMessage: "Sign-in failed");
//       }
//     } else {
//       state = state.copyWith(errorMessage: "Email and password are required");
//     }
//   }
// }
// class PatientAuthState {
//   final String firstName;
//   final String lastName;
//   final String password;
//   final bool passwordObscure;
//   final String email;
//   final bool loading;
//   final String errorMessage;
//   final String successMessage;

//   PatientAuthState({
//     this.firstName = "",
//     this.lastName = "",
//     this.password = "",
//     this.email = "",
//     this.loading = false,
//     this.errorMessage = "",
//     this.successMessage = "",
//     this.passwordObscure = true
//   });

//   PatientAuthState copyWith({
//     String? firstName,
//     String? lastName,
//     String? password,
//     String? email,
//     bool? loading,
//     String? errorMessage,
//     String? successMessage,
//     bool? passwordObscure
//   }) {
//     return PatientAuthState(
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       password: password ?? this.password,
//       email: email ?? this.email,
//       loading: loading ?? this.loading,
//       errorMessage: errorMessage ?? this.errorMessage,
//       successMessage: successMessage ?? this.successMessage,
//       passwordObscure: passwordObscure ?? this.passwordObscure
//     );
//   }
// }

// final authControllerProvider = StateNotifierProvider.autoDispose<AuthController, PatientAuthState>((ref) => AuthController());

class AuthController extends ChangeNotifier {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  bool isLoading = false;
  bool passwordObscure = true;
  PatientSex sex = PatientSex.male;
  TextEditingController sexFieldController = TextEditingController();
  Ref ref;
  AuthController({
    required this.ref,
  });
  signUp(BuildContext context) async {
    // toggleLoading();

    // try{

    EasyLoading.show();

    final patientApi = ref.read(patientApiProvider);
    final responseOrError =
        await patientApi.patientSignUp(firstName, lastName, email, password);
    // if (response == null ) return;
    responseOrError.fold((errorString) {
      return showSnackBar(context, errorString);
    }, (response) {
      final myResponse = ResponseApi.fromMap(json.decode(response.body));
      handleResponse(
          response: response,
          context: context,
          onSuccess: () {
            showMyDialog(
              context,
              myResponse.msg,
              () => Navigator.of(context).pushNamed(Routes.patientSignIn),
              "Log In",
            );
          });
    });

    // toggleLoading();
    EasyLoading.dismiss();

    // } catch (e){
    //   // toggleLoading();
    //    EasyLoading.dismiss();
    //   print("---->  $e");

    // showSnackBar(context, e.toString());
    // }
  }

  setEmail(String email) {
    copyWith(email: email);
  }

  setpassword(String password) {
    copyWith(password: password);
  }

  setFirstName(String firstName) {
    copyWith(firstName: firstName);
  }

  setLastName(String lastName) {
    copyWith(lastName: lastName);
  }

  setSex(PatientSex sex) {
    sexFieldController.text = sex.name;
    copyWith(sex: sex);
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  togglePasswordObscure() {
    passwordObscure = !passwordObscure;
    notifyListeners();
  }

  copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    PatientSex? sex,
    // bool? isLoading
  }) {
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.sex = sex ?? this.sex;
    // this.isLoading = isLoading ?? this.isLoading;

    notifyListeners();
  }
}

enum PatientSex { male, female }

final authControllerProvider =
    ChangeNotifierProvider.autoDispose((ref) => AuthController(ref: ref));
