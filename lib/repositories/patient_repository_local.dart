import 'package:booking_system/utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/patients/patient_model.dart';

abstract class PatientLocalRepository {
  // save patient locall 
  Future savePatientToken(String token);
  Future<String> getPatientToken();
  Future<Patient> savePatient(Patient patient);
  Future<Patient> getPatient();
}
 
 class PatientLocalRepoImpl extends PatientLocalRepository{

  
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
      String patientToken = tokenBox.get(AppConstants.patientTokenKey, defaultValue: "");
      tokenBox.close();
      return patientToken;
    } catch (e){
      print("get patient token error ${e}");
      return e.toString();
    }
  }

  @override
  Future<Patient> savePatient(Patient patient) {
    // TODO: implement savePatient
    throw UnimplementedError();
  }

  @override
  Future<Patient> getPatient() {
    // TODO: implement getPatient
    throw UnimplementedError();
  }
 
  
// TODO: we have to save the role of this user in order, when the user open the app we will 
// automatically know which type of this user doctor or patient
  
 

 }

final patientLocalProvider = Provider((ref) => PatientLocalRepoImpl());

