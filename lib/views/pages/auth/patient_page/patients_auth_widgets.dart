import 'package:booking_system/views/pages/auth/patient_page/sign_up/p_sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientSexRadioButton extends StatelessWidget {
  const PatientSexRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      
      final controller = ref.watch(authControllerProvider);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.w,
            child: Divider()),
          ListTile(
            title: const Text('Male'),
            leading: Radio<PatientSex>(
              value: PatientSex.male,
              groupValue: controller.sex,
              onChanged: (value) {
                ref
                    .read(authControllerProvider)
                    .setSex(value ?? PatientSex.male);
              },
            ),
          ),
          ListTile(
            title: const Text('Female'),
            leading: Radio<PatientSex>(
              value: PatientSex.female,
              groupValue: controller.sex,
              onChanged: (value) {
                ref
                    .read(authControllerProvider)
                    .setSex(value ?? PatientSex.female);
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"))
        ],
      );
    });
  }
}
