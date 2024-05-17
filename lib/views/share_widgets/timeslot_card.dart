// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  final TimeOfDay timeSlot;
  final bool selected;
  const TimeSlot({
    Key? key,
    required this.timeSlot,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: selected ? 10 : 0,
        color: timeSlot.minute % 2 == 0
            ? Color.fromARGB(255, 176, 226, 179)
            : Color.fromARGB(255, 252, 165, 159),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: selected ? Colors.black : Colors.transparent, width: 2),
        ),
        child: Center(
            child: Text(
          "${timeSlot.hour.toString()}:${timeSlot.minute.toString()}",
          style: TextStyle(fontSize: 20),
        )));
  }
}
