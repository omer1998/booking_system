import 'package:booking_system/views/pages/doctor/widgets/doctor_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category name") ,
        backgroundColor: Colors.white,
      ), 
      body:  SingleChildScrollView(
        child: Container(
          margin:  EdgeInsets.symmetric( vertical:8.0.h, horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
        
            children: [
              PersonalImageSlider(),
              PersonalInfo(name: "Omer faris nawar", speciality: 'Cardiologist' ),
              ProfessionalStatment(statement: "Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris Omer faris"),
              WorksDays(days: "all", time: "3 to 9", holiday: "friday and sunday"),
              Location(location : "Baghdad, al karada, Al wathiq square, 52 str"),
              GoogleLocation(latitude: 33.31016839890198, longitude: 44.363591018699346,),
              ActionButtons()
            ],
          ),
        ),
      ),
    );
  }
}