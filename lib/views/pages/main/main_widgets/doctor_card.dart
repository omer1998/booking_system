import 'package:booking_system/utilities/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../models/doctor.dart';

class DoctorCard extends StatefulWidget {
  final Doctor doctor;


  const DoctorCard({super.key,required this.doctor});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context , Routes.doctorPage, arguments: widget.doctor),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.doctor.image_profile_url ?? "https://img.freepik.com/premium-vector/doctor-icon-avatar-white_136162-58.jpg?w=2000"),
                  minRadius: 30.0,
                  maxRadius: 40.0,
                ),
              ),
            // Container(
            //   width: 100,
            //   height: 100,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage(
            //             'assets/images/doctor-image.jpg',
            //           ),
            //           fit: BoxFit.cover)),
            // ),
            // Image.asset('assets/images/doctor-image.jpg'), // image path, say from CodeGeeX or similar. Dart task.
        
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${widget.doctor.first_name} ${widget.doctor.last_name}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // title / description
                  Text(widget.doctor.speciality),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context)!.appointment),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.message_rounded), color: Colors.grey, splashRadius: 18,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite), color: Colors.grey, splashRadius: 18,),
        
                    ],
                  ),
                ],
              ),
            )
            // name
        
            // book now button
          ]),
        ),
      ),
    );
  }
}
