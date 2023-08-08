import 'dart:io';

import 'package:booking_system/views/pages/doctor/widgets/doctor_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pusher_client_fixed/pusher_client_fixed.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
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
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late IO.Socket socket;
  // late final pusherClient;
  // late final channel;

  @override
  void initState() {
    print("----------------before initSoket----------------");
    initSocket();
    super.initState();
  }

  initSocket() async {
     socket = IO.io('http://10.0.2.2:3000',
    IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      // .setExtraHeaders({'foo': 'bar'}) // optional
      .build()
  );
socket.connect();
socket.onError((data) => print("error: $data"));
// socket.emit('booking-dates', "booking date");
socket.on("booking-dates", (data) => print("data: $data"));



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
  }

  @override
  void dispose() {
    socket.disconnect();

    socket.dispose();
    // client.disconnect();
    // client.dipose();
    // channel.unbind(eventName); // Replace with your event name
    // pusherClient.unsubscribe(channelName); // Replace with your channel name
    // pusherClient.disconnect();
    // pusher.disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category name"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PersonalImageSlider(),
              PersonalInfo(
                  name: "Omer faris nawar", speciality: 'Cardiologist'),
              ProfessionalStatment(
                  statement:
                      "Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris"),
              WorksDays(
                  days: "all", time: "3 to 9", holiday: "friday and sunday"),
              Location(
                  location: "Baghdad, al karada, Al wathiq square, 52 str"),
              // GoogleLocation(
              //   latitude: 33.31016839890198,
              //   longitude: 44.363591018699346,
              // ),
              ActionButtons()
            ],
          ),
        ),
      ),
    );
  }
}
