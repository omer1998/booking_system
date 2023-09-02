import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingPageController extends ChangeNotifier {
  BookingPageController({required this.date, required this.time});

   DateTime date;
   TimeOfDay time;

  copyWith({ DateTime? date, TimeOfDay? time}) {
    this.date = date ?? this.date;
    this.time = time ?? this.time;
    notifyListeners();
  }
}

final bookingPageProvider =
    ChangeNotifierProvider<BookingPageController>((ref) {
  return BookingPageController(date: DateTime.now(), time: TimeOfDay.now());
});
