import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Clinic {
  final String clinic_name;
  final int working_hours;
  final int clinic_start_time;
  final int clinic_end_time;
  final String governorate;
  final String city;
  final String? town;
  final String? street_name;
  final String? additional_address_info;
  final double? latitude;
  final double? longitude;
  final String? clinic_phone;  // think if it must be required 
  final String? clinic_email;
  final String? clinic_photo_url;
  final int? patient_number_each_Day;
  final int appointment_duration;
  Clinic({
    required this.clinic_name,
    required this.working_hours,
    required this.clinic_start_time,
    required this.clinic_end_time,
    required this.governorate,
    required this.city,
    required this.appointment_duration,
    this.town,
    this.street_name,
    this.additional_address_info,
    this.latitude,
    this.longitude,
    this.clinic_phone,
    this.clinic_email,
    this.clinic_photo_url,
    this.patient_number_each_Day
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinic_name': clinic_name,
      'working_hours': working_hours,
      'clinic_start_time': clinic_start_time,
      'clinic_end_time': clinic_end_time,
      'governorate': governorate,
      'city': city,
      'town': town,
      'street_name': street_name,
      'additional_address_info': additional_address_info,
      'latitude': latitude,
      'longitude': longitude,
      'clinic_phone': clinic_phone,
      'clinic_email': clinic_email,
      'clinic_photo_url': clinic_photo_url,
      "patient_number_each_Day": patient_number_each_Day,
      "appointment_duration": appointment_duration
    };
  }

  factory Clinic.fromMap(Map<String, dynamic> map) {
    return Clinic(
      clinic_name: map['clinic_name'] as String,
      working_hours: map['working_hours'] as int,
      clinic_start_time: map['clinic_start_time'] as int,
      clinic_end_time: map['clinic_end_time'] as int,
      governorate: map['governorate'] as String,
      city: map['city'] as String,
      town: map['town'] != null ? map['town'] as String : null,
      street_name: map['street_name'] != null ? map['street_name'] as String : null,
      additional_address_info: map['additional_address_info'] != null ? map['additional_address_info'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      clinic_phone: map['clinic_phone'] != null ? map['clinic_phone'] as String : null,
      clinic_email: map['clinic_email'] != null ? map['clinic_email'] as String : null,
      clinic_photo_url: map['clinic_photo_url'] != null ? map['clinic_photo_url'] as String : null,
      patient_number_each_Day: map["patient_number_each_Day"] != null ? map["patient_number_each_Day"] as int : null,
      appointment_duration: map["appointment_duration"]
    );
  }

  String toJson() => json.encode(toMap());

  factory Clinic.fromJson(String source) => Clinic.fromMap(json.decode(source) as Map<String, dynamic>);
}
