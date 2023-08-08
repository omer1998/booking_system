import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booking_system/models/api/response.dart';
import 'package:booking_system/repositories/patient_repository_local.dart';
import 'package:booking_system/utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart%20';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import "package:http/http.dart" as http;

abstract class PatientRepository {
  patientSignUp(
      String firstName, String lastName, String email, String password);
  patientLogIn(Map<String, dynamic> body);
  checkPatientAuthValidation();
}

class PatientApi extends PatientRepository {
  final Ref ref;
  PatientApi(this.ref);

  @override
  Future<Either<String, http.Response>> patientLogIn(
      Map<String, dynamic> body) async {
    // do it later
    try {
      http.Response response = await http.post(
          Uri.parse("${AppConstants.appUrl}/api/patient/signin"),
          body: json.encode(body),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json"
          });
      return right(response);
    } on TimeoutException catch (e) {
      print("timeoutexception: ${e.message}");

      return left(e.message!);
    } on SocketException catch (e) {
      if (e.message == "Connection failed") {
        return left("No Internet Connection");
      }
      print("socketException: ${e}");

      return left(e.message);
    } on ClientException catch (e) {
      print("clientException: ${e.message}");

      return left(e.message);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, http.Response>> patientSignUp(
      String firstName, String lastName, String email, String password) async {
    // final patientAuthService = ref.read(patientAuthServiceProvider);
    try {
      var body = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
      };
      http.Response response = await http.post(
          Uri.parse("${AppConstants.appUrl}/api/patient/signup"),
          body: json.encode(body),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json"
          });
      // .timeout(const Duration(seconds: 5), onTimeout: () {});
      return right(response);
    } on TimeoutException catch (e) {
      print("timeoutexception: ${e.message}");
      return left(e.message!);
    } on SocketException catch (e) {
      print("socketException: ${e.message}");
      if (e.message == "Connection failed") {
        return left("No Internet Connection");
      }

      return left(e.message);
    } on ClientException catch (e) {
      print("clientException: ${e.message}");

      return left(e.message);
    }
  }

  @override
  checkPatientAuthValidation() async {
    final patientLocalRepo = ref.read(patientLocalProvider);
    final token = await patientLocalRepo.getPatientToken();
    try {
      final response = await http.get(
          Uri.parse("${AppConstants.appUrl}/api/patient/auth-validation"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token
          });
        
          return response;
    } catch (e) {
      print("patient auth validation ${e}");
    }
  }
}

// making provider for this repository
final patientApiProvider = Provider((ref) => PatientApi(ref));
