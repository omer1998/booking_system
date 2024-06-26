import 'package:booking_system/utilities/routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;



class PersonalImageSlider extends StatelessWidget {
  final String imgUrl;
  const PersonalImageSlider({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final doctorImagesAsset = ["assets/images/doctor-image.jpg"];
    return CarouselSlider.builder(
      itemCount: 1,
      itemBuilder: (context, index, realIndex) {
        return Image.network(imgUrl, fit: BoxFit.cover,);
      },
      options:
          CarouselOptions(enlargeCenterPage: true, clipBehavior: Clip.none),
    );
  }
}

class PersonalInfo extends StatelessWidget {
  final String name;
  final String speciality;
  const PersonalInfo({
    super.key,
    required this.name,
    required this.speciality,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Dr. $name",
                  style: theme.headlineMedium!.copyWith(
                    fontSize: 22.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              Text(
                speciality,
                style: theme.headlineSmall!
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              IconButton(onPressed: () {}, icon: Icon(MdiIcons.chat))
            ],
          )
        ],
      ),
    );
  }
}

class ProfessionalStatment extends StatelessWidget {
  final String statement;
  const ProfessionalStatment({super.key, required this.statement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
      child: Text(
        statement,
        style: theme.bodyMedium!.copyWith(fontSize: 14.sp),
      ),
    );
  }
}

class Location extends StatelessWidget {
  final String location;
  const Location({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Icon(Icons.location_on, color: Theme.of(context).primaryColor,),
                Text(
                  "Location",
                  style: theme.headlineSmall,
                ),
              ],
            ),
            Text(
              location,
              style: theme.bodyMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ));
  }
}

class WorksDays extends StatelessWidget {
  final String days;
  final String time;
  final String? holiday;
  const WorksDays(
      {super.key, required this.days, required this.time, this.holiday});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: Theme.of(context).primaryColor,),
                Text(
                  "Working Days",
                  style: theme.headlineSmall,
                ),
              ],
            ),
            Text(
              "$days",
              style: theme.bodyMedium!.copyWith(fontSize: 14.sp),
            ),
            Text(
              "Time: ${time}",
              style: theme.bodyMedium!.copyWith(fontSize: 11.sp),
            ),
            holiday != null
                ? Text(
                    "Holiday: ${holiday!}",
                    style: theme.bodyMedium!.copyWith(fontSize: 11.sp),
                  )
                : Text(" ")
          ],
        ));
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.bookingPage);
              },
              child: Text("Appointment"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w))),
            ),
            SizedBox(
              width: 5.w,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Chat"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w))),
            )
          ],
        ));
  }
}

class GoogleLocation extends StatelessWidget {
  final double longitude;
  final double latitude;
  const GoogleLocation({super.key,  required this.latitude, required this.longitude,});

  @override
  Widget build(BuildContext context) {
    final CameraPosition doctorPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 16.0,
        // tilt: 20.0,
        bearing: 0.0);
    return SizedBox(
      // clipBehavior: Clip.hardEdge,
      // decoration:BoxDecoration(
      //   borderRadius: BorderRadius.circular(40),
      //   border: Border.all(width: 2)
      // ) ,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(30)
      // ),
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      child: ClipRRect(
        borderRadius:BorderRadius.circular(30) ,
        child: GoogleMap(
          initialCameraPosition: doctorPosition,
          markers: {
            Marker(
              markerId: MarkerId("#1"),
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(
                title: "Doctor Location"
              )
            ),
          },
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          // trafficEnabled: true,
        ),
      ),
    );
  }
}


class ContactInfo extends StatelessWidget {
  final String clinicPhone;
  final String? clinicEmail;
  const ContactInfo({super.key, required this.clinicPhone, this.clinicEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.phone, color: Theme.of(context).primaryColor,),
              Text(
                  "Contact",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
            ],
          ),
          Text(
            "Phone: $clinicPhone",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          clinicEmail != null ?
          Text(
            "Clinic Email: $clinicEmail",
            style: Theme.of(context).textTheme.bodyMedium,
          ): Container()
        ],
      ),
    );
  }
}