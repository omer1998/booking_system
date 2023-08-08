import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Patient {
  int id;
  String first_name;
  String last_name;
  String? date_of_birth;
  String email;
  String? phone;
  String? government;
  String? city;
  String? longitude;
  String? latitude;
  Patient({
    required this.id,
    required this.first_name,
    required this.last_name,
    this.date_of_birth,
    required this.email,
    this.phone,
    this.government,
    this.city,
    this.longitude,
    this.latitude,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'date_of_birth': date_of_birth,
      'email': email,
      'phone': phone,
      'government': government,
      'city': city,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as int,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      date_of_birth: map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      email: map['email'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      government: map['government'] != null ? map['government'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) => Patient.fromMap(json.decode(source) as Map<String, dynamic>);
}
