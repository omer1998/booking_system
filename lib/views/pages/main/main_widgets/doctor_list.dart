import 'package:flutter/cupertino.dart';

import 'doctor_card.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
        ],
      ),
    );
  }
}
