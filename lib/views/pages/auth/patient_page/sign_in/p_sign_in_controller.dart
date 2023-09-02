// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_system/repositories/patient_repository_local.dart';
import 'package:booking_system/repositories/patient_repository_remote.dart';
import 'package:booking_system/utilities/handle_response.dart';
import 'package:booking_system/utilities/routes.dart';
import 'package:booking_system/views/share_widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/api/response.dart';

class PatientSignInNotifier extends StateNotifier<PatientSignInPageState> {
  final Ref ref;
  PatientSignInNotifier({required this.ref})
      : super(PatientSignInPageState(
            passwordObscure: true, email: "", password: ""));

  void setEmail(String email) {
    state = state.copyWith(email: email);
    print(state.email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
    print(state.password);
  }

  void togglePasswordObscure() {
    state = state.copyWith(passwordObscure: !state.passwordObscure);
  }

  void signIn(BuildContext context) async {
    final patientApi = ref.read(patientApiProvider);

    EasyLoading.show();
    final responseOrError = await patientApi.patientLogIn(state.toMap());
    responseOrError.fold((error) {
      EasyLoading.dismiss();
      showSnackBar(context, error);
    }, (response) {
      final myResponse = ResponseApi.fromJson(response.body);
      EasyLoading.dismiss();
      handleResponse(
          response: response,
          context: context,
          onSuccess: () {
            try {
              ref
                  .read(patientLocalProvider)
                  .savePatientToken(myResponse.token!);
              showSnackBar(context,"Token is saved");

            } catch (e) {
              print(e);
              showSnackBar(context, e.toString());
              return;
            }
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.mainPage, (route) => false, arguments: myResponse.user);
                // we give the user detail to the main page of the user
          });
    });
  }

  checkPatientAuthValidation(BuildContext context) async {
    try {
      final response = await ref.read(patientApiProvider).checkPatientAuthValidation();
      print("sign in controller --> ${response.body}");
      final authValidationState = json.decode(response.body);
      if(authValidationState == true){
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.mainPage, (route) => false);

      }
    } catch (e) {
      print(e); 
    }
  }
}

class PatientSignInPageState {
  final String email;
  final String password;
  final bool passwordObscure;

  PatientSignInPageState(
      {required this.passwordObscure,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  PatientSignInPageState copyWith({
    String? email,
    String? password,
    bool? passwordObscure,
  }) {
    return PatientSignInPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordObscure: passwordObscure ?? this.passwordObscure,
    );
  }
}

final patientSignInNotifierProvider =
    StateNotifierProvider<PatientSignInNotifier, PatientSignInPageState>(
        (ref) => PatientSignInNotifier(ref: ref));
