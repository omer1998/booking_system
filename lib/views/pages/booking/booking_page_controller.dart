import 'package:booking_system/models/patients/patient_model.dart';
import 'package:booking_system/repositories/patient_repository_remote.dart';
import 'package:booking_system/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/doctor.dart';

class BookingPageController extends ChangeNotifier {
  BookingPageController({required this.ref ,required this.date, required this.time});
  
  Ref ref;
   DateTime date;
   TimeOfDay time;

  copyWith({ DateTime? date, TimeOfDay? time}) {
    this.date = date ?? this.date;
    this.time = time ?? this.time;
    notifyListeners();
  }

  bookDate(int patientId, int doctorId)async {
    final patient = ref.read(patientProvider);
    final doctor = ref.read(doctorProvider);
    final remoteRepo = ref.read(patientApiProvider);

    TimeOfDayFormat.HH_colon_mm;
    await remoteRepo.bookDate(date, time, patient!.id, doctor!.id);
    print("time selected ${time.to24Hours()}");
    print("patient id: ${patient!.id}, doctor id: ${doctor!.id}");
  }
}

final bookingPageProvider =
    ChangeNotifierProvider<BookingPageController>((ref) {
  return BookingPageController(ref: ref, date: DateTime.now(), time: TimeOfDay.now());
});
