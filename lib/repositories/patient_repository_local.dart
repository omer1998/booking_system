import 'dart:ffi';

import 'package:booking_system/utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

import '../models/patients/patient_model.dart';

abstract class PatientLocalRepository {
  // save patient locall
  Future savePatientToken(String token);
  Future<String> getPatientToken();
  Either<String, void>savePatient(Patient patient);
  Future<Patient?> getPatient();
}

class PatientLocalRepoImpl extends PatientLocalRepository {
  @override
  Future savePatientToken(String token) async {
    final tokenBox = await Hive.openBox(AppConstants.tokenBox);
    try {
      tokenBox.put(AppConstants.patientTokenKey, token);
      tokenBox.close();
    } catch (e) {
      print("save token error $e");
    }
  }

  @override
  Future<String> getPatientToken() async {
    final tokenBox = await Hive.openBox(AppConstants.tokenBox);
    try {
      String patientToken =
          tokenBox.get(AppConstants.patientTokenKey, defaultValue: "");
      tokenBox.close();
      return patientToken;
    } catch (e) {
      print("get patient token error ${e}");
      return e.toString();
    }
  }

  @override
  savePatient(Patient patient) async {
    try {
      final patientBox = await Hive.openBox<Patient>(AppConstants.patientBox);
      patientBox.put(AppConstants.patientKey,patient);
      patientBox.compact();
      patientBox.close();
      return const Right(Void);
      
    } catch (e) {
      print("error saving patient locally $e");
      return Left(e.toString());
    }
  }

  @override
  Future<Patient?> getPatient() async{
    final patientBox = await Hive.openBox<Patient>(AppConstants.patientBox);
    final patient = patientBox.get(AppConstants.patientKey);
    return patient;
  }

// TODO: we have to save the role of this user in order, when the user open the app we will
// automatically know which type of this user doctor or patient
}

final patientLocalProvider = Provider((ref) => PatientLocalRepoImpl());
