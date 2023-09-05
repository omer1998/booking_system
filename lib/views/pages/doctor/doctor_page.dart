
import 'package:booking_system/views/pages/doctor/widgets/doctor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

import 'package:pusher_client_fixed/pusher_client_fixed.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../models/doctor.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart';

const String appId = "1321495";
const String key = "app-key";
const String cluster = "mt1";
const String hostEndPoint = "10.0.0.2";
const String hostAuthEndPoint = "http://$hostEndPoint/broadcasting/auth";
const String token = "34|yzWaxwGZz75Xqk4tXviP4uhAc0sVB14OLVXEmoxg";
const int port = 6001;
const String channelName = 'booking-dates';
const String eventName = 'BookingDates';

class DoctorPage extends StatefulWidget {
  final Doctor doctor;
  const DoctorPage({super.key, required this.doctor});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  // late IO.Socket socket;
  // late final pusherClient;
  // late final channel;

  @override
  void initState() {
    print("----------------before initSoket----------------");
    // initSocket();
    // super.initState();
  }

//   initSocket() async {
//      socket = IO.io('http://10.0.2.2:3000',
//     IO.OptionBuilder()
//       .setTransports(['websocket']) // for Flutter or Dart VM
//       .disableAutoConnect()  // disable auto-connection
//       // .setExtraHeaders({'foo': 'bar'}) // optional
//       .build()
//   );
// socket.connect();
// socket.onError((data) => print("error: $data"));
// // socket.emit('booking-dates', "booking date");
// socket.on("booking-dates", (data) => print("data: $data"));



//     pusherClient = PusherClient(
//       key,
//       PusherOptions(
//         host: hostEndPoint,
//         encrypted: false,
//         cluster: cluster,
//         wsPort: port,
//         // auth: PusherAuth(
//         //   hostAuthEndPoint,
//         //   headers: {
//         //     'Authorization': 'Bearer $token',
//         //   },
//         // ),
//       ),
//       autoConnect: false,
//       enableLogging: true,
//     );
    
//     channel = pusherClient.subscribe(channelName);

//     channel.bind(eventName, (event) {
//       print("event: $event?.data");
//     });

// pusherClient.connect();
//     pusherClient.onConnectionError((error) {
//       print("error: ${error.message}");
//     });
    

    // pusherClient.onConnectionStateChange((state) {
    //   print(
    //     "previousState: ${state?.previousState}, currentState: ${state?.currentState}",
    //   );
    // });

    
//     PusherOptions options = PusherOptions(
//       host: "ws://10.0.0.2",

//       wsPort: 6001,
//       cluster: "mt1",
//       encrypted: false,
//       // auth: PusherAuth(
//       //     'http://example.com/auth',
//       //     headers: {
//       //         'Authorization': 'Bearer $token',
//       //     },
//       // ),
//     );

//     pusher = PusherClient("app-key", options, autoConnect: false);

// // connect at a later time than at instantiation.
//     await pusher.connect(
//       );
//     pusher.onConnectionError((error) {
//       print("error: ${error}");
//     });

// // Subscribe to a private channel
//    channel = pusher.subscribe("omer");

// // emit event to this channel
//     channel.bind("omer", (event, ) {
//       print(event!.data);
//     });

// // Bind to listen for events called "order-status-updated" sent to "private-orders" channel
//     channel.bind("BookingDates", (event) {
//       print("event data" + event!.data);
//     });



//
  // }

  @override
  void dispose() {
    // socket.disconnect();

    // socket.dispose();
    

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category name"),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PersonalImageSlider(imgUrl: widget.doctor.image_profile_url ?? "https://img.freepik.com/premium-vector/doctor-icon-avatar-white_136162-58.jpg?w=2000",),
              PersonalInfo(
                  name: "${widget.doctor.first_name} ${widget.doctor.last_name}", speciality: widget.doctor.speciality),
              ProfessionalStatment(
                  statement: widget.doctor.professional_statment ?? ""
                     ),
              WorksDays(
                  days: "All days", time: "${widget.doctor.clinic.clinic_start_time} to ${widget.doctor.clinic.clinic_end_time}", holiday: "friday and sunday"),
              // ContactInfo(),
              Location(
                // governorate -- city -- town -- street
                  location: "${widget.doctor.clinic.governorate} ${widget.doctor.clinic.city} ${widget.doctor.clinic.town ??""} ${widget.doctor.clinic.street_name??""} ${widget.doctor.clinic.additional_address_info ?? ""}"),
              widget.doctor.clinic.latitude != null && widget.doctor.clinic.longitude != null ?
              GoogleLocation(
                latitude: widget.doctor.clinic.latitude!,
                longitude: widget.doctor.clinic.longitude!,
              ): Container(),
              widget.doctor.clinic.clinic_phone != null ?
              ContactInfo(clinicPhone: widget.doctor.clinic.clinic_phone!, clinicEmail: widget.doctor.clinic.clinic_email,) : 
              Container(),
              ActionButtons()
            ],
          ),
        ),
      ),
    );
  }
}
