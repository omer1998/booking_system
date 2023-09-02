// import 'package:booking_calendar/booking_calendar.dart';
import 'package:booking_system/views/pages/auth/auth_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking_page_controller.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BookingPageState();
}

class BookingPageState extends ConsumerState<BookingPage> {
  _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (selectedDate != null &&
        selectedDate != ref.read(bookingPageProvider).date) {
      ref.read(bookingPageProvider.notifier).copyWith(date: selectedDate);
      print(selectedDate);
    }
    print("the date inside the riverpod controller ${ref.read(bookingPageProvider).date}");

  }

  _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null &&
        selectedTime != ref.read(bookingPageProvider).time) {
      print(selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return BookingCalendar(bookingService: Booking, getBookingStream: getBookingStream, uploadBooking: (Booking){ }, convertStreamResultToDateTimeRanges: convertStreamResultToDateTimeRanges);
    final bookingPageController = ref.watch(bookingPageProvider);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 100.w,
              ),
              CustomStepTitle(title: "Select the date"),
              TextButton(
                  onPressed: () {
                      _selectDate(context);
                  },
                  child: Text(ref.watch(bookingPageProvider).date.toIso8601String())),
              ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text("Select Date")),
              ElevatedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text("Select Time"))

              // Text()
            ]),
      ))),
    );
  }

  // BookingService Booking = BookingService(bookingStart: DateTime.now(), bookingEnd: DateTime(2023, 6,23), serviceName: "Counsultation", serviceDuration: 30);
}
