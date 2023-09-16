// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'clinic.dart';

class Doctor {
  final int id;
  final String first_name;
  final String last_name;
  final Clinic clinic;
  final String speciality;
  final String? practising_from;
  final String? professional_statment;
  
  final String email_address;
  final String? image_profile_url;
  
  Doctor({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.speciality,
    this.practising_from,
    this.professional_statment,
    required this.email_address,
    this.image_profile_url,
    required this.clinic,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      "speciality": speciality,
      'practising_from': practising_from,
      'professional_statment': professional_statment,
      'email_address': email_address,
      'image_profile_url': image_profile_url,
      'clinic': clinic.toMap(),
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as int,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      speciality: map['speciality'] as String,
      practising_from: map['practising_from'] != null ? map['practising_from'] as String : null,
      professional_statment: map['professional_statment'] != null ? map['professional_statment'] as String : null,
      email_address: map['email_address'] as String,
      image_profile_url: map['image_profile_url'] != null ? map['image_profile_url'] as String : null,
      clinic: Clinic.fromMap(map['clinic'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source) as Map<String, dynamic>);
}

// provider for the doctor model
final doctorProvider = StateProvider<Doctor?>((ref) => null);