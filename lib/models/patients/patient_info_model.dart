// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PatientInfo {
  final int age;
  final String sex;
  final String profile_image;

  PatientInfo({required this.age, required this.sex, required this.profile_image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'age': age,
      'sex': sex,
      'profile_image': profile_image,
    };
  }

  factory PatientInfo.fromMap(Map<String, dynamic> map) {
    return PatientInfo(
      age: map['age'] as int,
      sex: map['sex'] as String,
      profile_image: map['profile_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientInfo.fromJson(String source) => PatientInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
