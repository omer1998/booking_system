// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Doctor {
  final String firstName;
  final String lastName;
  final String? practisingFrom;
  final String? professionalStatment;
  final String phone;
  final String password;
  final String emailAddress;

  Doctor({
    required this.firstName,
    required this.lastName,
    this.practisingFrom,
    this.professionalStatment,
    required this.phone,
    required this.password,
    required this.emailAddress,
  });

  Doctor copyWith({
    String? firstName,
    String? lastName,
    String? practisingFrom,
    String? professionalStatment,
    String? phone,
    String? password,
    String? emailAddress,
  }) {
    return Doctor(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      practisingFrom: practisingFrom ?? this.practisingFrom,
      professionalStatment: professionalStatment ?? this.professionalStatment,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'practisingFrom': practisingFrom,
      'professionalStatment': professionalStatment,
      'phone': phone,
      'password': password,
      'emailAddress': emailAddress,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      practisingFrom: map['practisingFrom'] != null
          ? map['practisingFrom'] as String
          : null,
      professionalStatment: map['professionalStatment'] != null
          ? map['professionalStatment'] as String
          : null,
      phone: map['phone'] as String,
      password: map['password'] as String,
      emailAddress: map['emailAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) =>
      Doctor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor(firstName: $firstName, lastName: $lastName, practisingFrom: $practisingFrom, professionalStatment: $professionalStatment, phone: $phone, password: $password, emailAddress: $emailAddress)';
  }

  @override
  bool operator ==(covariant Doctor other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.practisingFrom == practisingFrom &&
        other.professionalStatment == professionalStatment &&
        other.phone == phone &&
        other.password == password &&
        other.emailAddress == emailAddress;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        practisingFrom.hashCode ^
        professionalStatment.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        emailAddress.hashCode;
  }
}

class DoctorNotifier extends StateNotifier<Doctor> {
  DoctorNotifier(super.state);

  update(
      String? firstName,
      String? lastName,
      String? practisingFrom,
      String? professionalStatment,
      String? phone,
      String? password,
      String? emailAddress) {
    state.copyWith(
        firstName: firstName,
        lastName: lastName,
        practisingFrom: practisingFrom,
        professionalStatment: professionalStatment,
        phone: phone,
        password: password,
        emailAddress: emailAddress);
  }
}
