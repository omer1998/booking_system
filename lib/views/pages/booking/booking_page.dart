// import 'package:booking_calendar/booking_calendar.dart';
import 'package:booking_system/models/doctor.dart';
import 'package:booking_system/models/patients/patient_model.dart';
import 'package:booking_system/utilities/extensions.dart';
import 'package:booking_system/views/pages/auth/auth_widgets.dart';
import 'package:booking_system/views/share_widgets/timeslot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'booking_page_controller.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BookingPageState();
}

class BookingPageState extends ConsumerState<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  _selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (selectedDate != null &&
        selectedDate != ref.read(bookingPageProvider).date) {
      ref.read(bookingPageProvider.notifier).copyWith(date: selectedDate);
      print(selectedDate);
      setState(() {});
    }
    print(
        "the date inside the riverpod controller ${ref.read(bookingPageProvider).date}");
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null &&
        selectedTime != ref.read(bookingPageProvider).time) {
      // print(selectedTime);
      ref.read(bookingPageProvider.notifier).copyWith(time: selectedTime);
      setState(() {});
    }
  }

  _selectThisTime(TimeOfDay time) {
    ref.read(bookingPageProvider.notifier).copyWith(time: time);
    selectedTime = time;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // return BookingCalendar(bookingService: Booking, getBookingStream: getBookingStream, uploadBooking: (Booking){ }, convertStreamResultToDateTimeRanges: convertStreamResultToDateTimeRanges);
    // final bookingPageController = ref.watch(bookingPageProvider);
    final doctor = ref.read(doctorProvider);
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
              doctor!.image_profile_url != null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(doctor.image_profile_url!))
                  : FlutterLogo(),
              CustomStepTitle(title: "Select the date"),

              // TextButton(
              //     onPressed: () {
              //       _selectDate(context);
              //     },
              //     child: Text(
              //         ref.watch(bookingPageProvider).date.toIso8601String())),
              ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text("Select Date")),
              // ElevatedButton(
              //     onPressed: () {
              //       _selectTime(context);
              //     },
              //     child: Text("Select Time")),

              // Text()
              SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                final doctor = ref.read(doctorProvider);
                var time = TimeOfDay(
                    hour: doctor!.clinic.clinic_start_time, minute: 0);
                final endTime =
                    TimeOfDay(hour: doctor.clinic.clinic_end_time, minute: 0);
                // int time = doctor!.clinic.clinic_start_time;
                List<TimeOfDay> timeSlots = [];
                print("clinic start time: ${doctor.clinic.clinic_start_time}");
                print("clinic end time: ${doctor.clinic.clinic_end_time}");
                TimeOfDay appointmentDuration = TimeOfDay(hour: 0, minute: 0)
                    .parseMins(doctor.clinic.appointment_duration);

                // print("appointment duration: ${appointmentDuration}");
                // print("time $time");
                // print("added time ${time.plusMinutes(appointmentDuration.minute)}");
                // time = time.plusMinutes(appointmentDuration.minute);
                // print("time $time");

                while (time.hour < endTime.hour) {
                  timeSlots.add(time);
                  time = time.plusMinutes(appointmentDuration.minute);
                  // print("time: $time");
                  // time.add(appointmentDuration.hour, appointmentDuration.minute);
                }

                print("time slots list: ${timeSlots.length}");
                // return SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.5,
                //   child: Text(time.toString())
                // );
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: timeSlots.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                // crossAxisSpacing: 10,
                                // mainAxisExtent: 10,
                                childAspectRatio: 2,
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          TimeOfDay timeSlot = timeSlots[index];
                          return InkWell(
                              onTap: () {
                                _selectThisTime(timeSlot);
                              },
                              child: TimeSlot(
                                  timeSlot: timeSlot,
                                  selected: selectedTime == timeSlot));
                        }));
              }),
              SizedBox(height: 20),
              Text(
                selectedDate != null
                    ? "Selected date: ${DateFormat.yMMMd().format(selectedDate!)}"
                    : "No date selected",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  selectedTime != null
                      ? "Selected time: ${selectedTime!.format(context)}"
                      : "No time selected",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 35),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                      onPressed: () {
                        final patient = ref.read(patientProvider);
                        // print(patient != null ? "${patient.id} ${patient.first_name} ${patient.last_name} ${patient.email} ": " no data");
                        final doctor = ref.read(doctorProvider);
                        final bookingPageController =
                            ref.read(bookingPageProvider);
                        bookingPageController.bookDate(
                            patient!.id, doctor!.id, context);
                      },
                      child: Text("Book Appointment"));
                },
              ),
              // Consumer(
              //   builder: (context, ref, child) {
              //     final controller = ref.watch(bookingPageProvider);
              //     return Column(
              //       children: [
              //         Text("Date: ${controller.date}"),
              //         Text("Time: ${controller.time.format(context)}"),
              //       ],
              //     );
              //   },
              // )
            ]),
      ))),
    );
  }

  // BookingService Booking = BookingService(bookingStart: DateTime.now(), bookingEnd: DateTime(2023, 6,23), serviceName: "Counsultation", serviceDuration: 30);
}
