// import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    // return BookingCalendar(bookingService: Booking, getBookingStream: getBookingStream, uploadBooking: (Booking){ }, convertStreamResultToDateTimeRanges: convertStreamResultToDateTimeRanges);
  return Scaffold(
    body: Column(
      children: <Widget>[
        Text("Hello World"),
        // Text()
    ])
  );
  }

  // BookingService Booking = BookingService(bookingStart: DateTime.now(), bookingEnd: DateTime(2023, 6,23), serviceName: "Counsultation", serviceDuration: 30);
}