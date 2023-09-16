import 'package:flutter/material.dart';

extension TimeOfDayConverter  on TimeOfDay{
  String to24Hours(){
    String hours = this.hour.toString().padLeft(2,"0");
    String minutes = this.minute.toString().padLeft(2,"0");
  return "$hours:$minutes";
  }
}