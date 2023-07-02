import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBar extends StatelessWidget {
  final String title;
  final String? action;
  const InfoBar({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          // if (action != null) {
          //   TextButton(onPressed: () {}, child: Text( action!))
          //   }
          action != null ? TextButton(onPressed: (){}, child: Text(action!))  : Text("")
        ],
      ),
    );
  }
}
