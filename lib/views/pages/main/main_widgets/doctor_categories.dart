import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DoctorCategories extends StatelessWidget {
  const DoctorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SpecialtyCard(specialtyName: "القلبيه"),
          SpecialtyCard(specialtyName: "القلبيه"),
          SpecialtyCard(specialtyName: "القلبيه"),
          SpecialtyCard(specialtyName: "القلبيه"),
          SpecialtyCard(specialtyName: "القلبيه"),
          SpecialtyCard(specialtyName: "القلبيه"),
          SpecialtyCard(specialtyName: "القلبيه"),
        ],
      ),
    );
  }
}

class SpecialtyCard extends StatelessWidget {
  final String specialtyName;
  const SpecialtyCard({super.key, required this.specialtyName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(5),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // IconButton(onPressed: (){}, icon: Icon(MdiIcons.heartCircle))
            
            
            CircleAvatar(
              // radius: 30.w,
              backgroundColor: Colors.grey.withOpacity(0.2),
              maxRadius: 40.w,
              child:Image.asset("assets/images/cardiology.png", width: 70.w, height: 70.h,) ,),
            Text(specialtyName, style: theme.textTheme.bodyLarge,),
            // ElevatedButton(onPressed: (){}, child: Text()),
            ElevatedButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context)!.more, style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white
                        ),),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),
          ],
        ),
      ) ,
    );
  }
}