import 'dart:convert';

import 'package:booking_system/models/patients/patient_info_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Patient {
  int id;
  String first_name;
  String last_name;
  PatientInfo? patient_info;
  
  String email;
  
  Patient({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    this.patient_info
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      "patient_info": patient_info !=null ? patient_info!.toMap() : null
      
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as int,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      
      email: map['email'] as String,
      patient_info: PatientInfo.fromMap(map["UserInfo"]) ,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) => Patient.fromMap(json.decode(source) as Map<String, dynamic>);
}
