
import 'package:flutter/material.dart';

extension TimeOfDayConverter  on TimeOfDay{
  String to24Hours(){
    String hours = this.hour.toString().padLeft(2,"0");
    String minutes = this.minute.toString().padLeft(2,"0");
  return "$hours:$minutes";
  }
}

// extension AddingTime on TimeOfDay{
//   TimeOfDay add(int hours, int mins){
//     return TimeOfDay(hour: this.hour + hours, minute: minute + mins);
//   }
// }
extension TimeOfDayExtension on TimeOfDay {
  // Ported from org.threeten.bp;
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = this.hour * 60 + this.minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}

extension ParsingTimeOfDay on TimeOfDay{
  TimeOfDay parse(String time){
    int hours = time.split(":")[0] as int;
    int minutes = time.split(":")[1] as int;
    return TimeOfDay(hour: hours , minute: minutes);
  }
  TimeOfDay parseMins(int mins){
    return TimeOfDay(hour: this.hour + 0, minute: this.minute + mins);
  }
}