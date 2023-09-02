import 'package:booking_system/views/pages/main/main_widgets/user_intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/patients/patient_model.dart';
import 'main_widgets/doctor_card.dart';
import 'main_widgets/doctor_categories.dart';
import 'main_widgets/doctor_list.dart';
import 'main_widgets/info_bar.dart';
import 'main_widgets/info_icons.dart';

class MainPage extends StatefulWidget {
  final Patient patient;
  const MainPage({super.key, required this.patient});

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    print("the patient is ${widget.patient.first_name}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   // toolbarHeight: 100.w,
        //   automaticallyImplyLeading: false,
        //   leading: InkWell(
        //     child: CircleAvatar(
        //       backgroundImage: AssetImage(
        //         "assets/images/doctor-image.jpg",
        //       ),
        //     ),
        //   ),
        //   actions: [
        //     IconButton(onPressed: (){}, icon: Icon(Icons.notifications_on, color: Colors.yellow[700],)),
        //     IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, color: Colors.black,)),
        //   ],
        //   bottom: PreferredSize(preferredSize: Size(50, 50),
        //   child: Container(height: 50.h, color: Colors.grey,)),

        // ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
              collapsedHeight: 70.h,
              stretch: true,
              // snap: false,
              pinned: true,
              floating: false,
              expandedHeight: 100.h,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundImage: widget.patient.patient_info!.profile_image != null ? NetworkImage(widget.patient.patient_info!.profile_image,) : AssetImage("assets/images/doctor-image.jpg") as ImageProvider,
                        ),
              ),
              // title: Text("omer"),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.5,
                // centerTitle: true,
                title: Text("hello, ${widget.patient.first_name} ${widget.patient.last_name}"),
                background: const Stack(
                  // fit: StackFit.expand,
                  children:  [
                    DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: AlignmentDirectional.bottomCenter,
                                colors: [
                          Color.fromARGB(95, 245, 105, 177),
                          Color.fromARGB(0, 169, 224, 229),
                        ])))
                  ],
                ),
              ),
            ),

            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: UserIntro(),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            const SliverToBoxAdapter(
              child: InfoIcons(),
            ) ,
            const SliverToBoxAdapter(
              child: InfoBar(title: "Categories",),
            ),
            const SliverToBoxAdapter(
              child: DoctorCategories(),
            ),
            const SliverToBoxAdapter(
              child: InfoBar(title: "Doctors", action: "See All",),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: 50,
                    (BuildContext context, int index) {
              return const DoctorCard();
            }))
          ],
        ));

    // Column(children: [DoctorCategories(), DoctorList()]),
  }
}
