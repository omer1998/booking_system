import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showImagePickerBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.w),
        topRight: Radius.circular(20.w),
      )
    ),
    useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
                decoration: BoxDecoration(
                  // color: Colors.red,
                 borderRadius: BorderRadius.circular(20.w)
                ),
                height: 150.h,
                child: Column(children: <Widget>[
                  // draw horizontal line
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(width:40,  child: Divider(thickness: 4,)),
                  ),

                  ListTile(
                    title: Text('Take a photo'),
                    onTap: (){
                      print("openning camera");
                    },
                  ),
                  ListTile(
                    title: Text('Choose a photo'),
                    onTap: (){
                      print("openning gallery");
                    },
                  )
                ]),
              );
            });
      }



// int numberOfCakes = 1;
// int numberOfCandles = 1;
// bool isCandleOn = true;
// bool isCakeColorful= true;
// int cakeColorNumber = 4;
// List<String> cakeColors = ["orange","yellow", "light blue","cyan" ];
// String giftName = "cake";
