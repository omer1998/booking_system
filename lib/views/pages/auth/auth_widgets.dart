// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInput extends StatelessWidget {
  final String fieldName;
  final String hint;
  final IconData iconData;
  final String? Function(String? val) validator;
  final TextInputType? textInputType;
  // ValueChanged<String>? onChanged;
  final Function(String val)? onChanged;
  final int? maxLines;
  final bool? obscureText;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconAction;
  final double? horizPad;
  final double? vertPad;
  final double? horizMar;
  final double? vertMar;
  
  const CustomInput(
      {Key? key,
      required this.fieldName,
      required this.validator,
      required this.iconData,
      required this.hint,
      this.textInputType,
      this.onChanged,
      this.maxLines,
      this.obscureText,
      this.suffixIcon,
      this.suffixIconAction,
      this.vertPad,
      this.horizPad,
      this.horizMar,
      this.vertMar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal:horizMar ?? 24, vertical: vertMar ??  8),
      padding: EdgeInsets.symmetric(horizontal:horizPad ?? 16, vertical: vertPad ?? 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        obscureText: obscureText ?? false,
        maxLines: maxLines ?? 1,
        onChanged: onChanged,
        autocorrect: true,
        enableSuggestions: true,
        keyboardType: textInputType,
        onSaved: (value) {},
        decoration: InputDecoration(
          // helperText: 
          labelText: fieldName,
          hintText: hint,
          // floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
          // labelStyle: TextStyle(
          //     color: Colors.blueGrey, fontSize: 15.sp, fontWeight: FontWeight.w500
          // ),
          // floatingLabelStyle: TextStyle(
          //     color: Colors.blueGrey, fontSize: 15.sp, fontWeight: FontWeight.w500
          // ),
          // floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixIconAction,
                  icon: Icon(suffixIcon),
                )
              : null,
          // hintText: fieldName,
          hintStyle: TextStyle(color: Colors.black54),
          icon: Icon(iconData, color: Colors.blue.shade700, size: 24),
          // alignLabelWithHint: true,
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            child: DropdownButtonFormField(
              items: ["079","077","075"].map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(),
              onChanged: (value){
                
              },
            ),
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: TextFormField(
              
              decoration: InputDecoration(
              
                hintText: "Enter Phone Number",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomStepperActions extends StatelessWidget {
  const CustomStepperActions({super.key, required this.onNextAction, required this.onBackAction});
  final VoidCallback onNextAction;
  final VoidCallback onBackAction;

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ) ,onPressed: onBackAction, child: Text("back")),
              SizedBox(
                width: 20.w,
              ),
              ElevatedButton(style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ) , onPressed: onNextAction, child: Text("Next")),
            ],
          );
  }
}

class CustomStepTitle extends StatelessWidget {
  final String title;
  const CustomStepTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Text(title, style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),),
    );
  }
}

class CustomDropdownInput extends StatelessWidget {
  final List<String> options;
  final String hint;
  const CustomDropdownInput({super.key, required this.options, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButtonFormField(
        value: options.first,
        hint: Text(hint),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        onChanged: (value) {
          print("governate $value");
        },
        items: options.map((option) => DropdownMenuItem(child: Text(option), value: option,)).toList()),
        
    );
  }
}

class CustomDocumentUploaderCard extends StatelessWidget {
  final VoidCallback onTap;
  final String documentName;
  const CustomDocumentUploaderCard({super.key, required this.onTap, required this.documentName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.w),
      onTap: onTap,
      child: Container(
        height: 75.h,
        child: Card(
          elevation: 7.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text("Upload $documentName", style: TextStyle(
                                fontWeight: FontWeight.w500
                              ),),
                  ),
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.headphones_battery
              ),
            )
              ],
            )
          ),
        ),
      ),
    );
  }
}