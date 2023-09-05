// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import '../doctor.dart';
import '../patients/patient_model.dart';

class ResponseApi {
  bool status;
  String msg;
  Patient? user;
  String? token;
  List<Doctor>? doctors;
  ResponseApi({
    required this.status,
    required this.msg,
    this.doctors,
    this.user,
    this.token,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'user': user?.toMap(),
      'token': token,
      "doctors": doctors != null ? doctors!.map((doctor) => doctor.toMap()).toList(): null
    };
  }

  factory ResponseApi.fromMap(Map<String, dynamic> map) {
    return ResponseApi(
      status: map['status'] as bool,
      msg: map['msg'] as String,
      user: map['user'] != null ? Patient.fromMap(map['user'])  : null,
      token: map['token'] != null ? map["token"]: null,
      doctors:  map['doctors'] != null ? (map["doctors"] as List<dynamic>).map((doctor) => Doctor.fromMap(doctor)).toList() : null,
      // previously i encountered error when the code written in this way : map["doctors"].map((doctor) => Doctor.fromMap(doctor)).toList()  and dart cannot map each doctor map to the doctor object and the explanation from chatgpt
      // The error occurred because Dart's type system was unable to automatically recognize the type of map["doctors"]. The type of map["doctors"] was inferred as List<dynamic>, which is a list that can hold elements of any type.
      // When you used .map((doctor) => Doctor.fromMap(doctor)) on this List<dynamic>, Dart didn't know what specific type the elements inside the list were, so it couldn't directly map them to Doctor objects.
      // By adding (map["doctors"] as List<dynamic>), you explicitly told Dart that you expect map["doctors"] to be a List<dynamic>. This casting informs Dart about the expected type, allowing it to correctly apply the .map((doctor) => Doctor.fromMap(doctor)) operation and create a List<Doctor>.
      // In summary, adding the cast with (map["doctors"] as List<dynamic>) helped Dart understand the type you intended, allowing it to perform the mapping correctly.
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseApi.fromJson(String source) => ResponseApi.fromMap(json.decode(source) as Map<String, dynamic>);
}
