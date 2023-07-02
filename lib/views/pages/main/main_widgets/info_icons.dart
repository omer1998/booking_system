import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InfoIcons extends StatelessWidget {
  const InfoIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InfoIcon(),
        InfoIcon(),
        InfoIcon(),
        InfoIcon(),
        ],
    );
  }
}

class InfoIcon extends StatelessWidget {
  const InfoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            // radius: 20.w,
            maxRadius: 25.w,
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: IconButton(onPressed: (){} ,icon: Icon(MdiIcons.pill), iconSize:35),) ,
          SizedBox(height: 5.h,),
          Text(
                "Pills",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}
