// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import '../patients/patient_model.dart';

class ResponseApi {
  bool status;
  String msg;
  Patient? user;
  String? token;
  ResponseApi({
    required this.status,
    required this.msg,
    this.user,
    this.token,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'user': user?.toMap(),
      'token': token,
    };
  }

  factory ResponseApi.fromMap(Map<String, dynamic> map) {
    return ResponseApi(
      status: map['status'] as bool,
      msg: map['msg'] as String,
      user: map['user'] != null ? Patient.fromMap(map['user'])  : null,
      token: map['token'] != null ? map["token"]: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseApi.fromJson(String source) => ResponseApi.fromMap(json.decode(source) as Map<String, dynamic>);
}
