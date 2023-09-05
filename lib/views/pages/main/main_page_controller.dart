import 'package:booking_system/models/doctor.dart';
import 'package:booking_system/repositories/patient_repository_remote.dart';
import 'package:booking_system/utilities/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/api/response.dart';

class MainPageController extends ChangeNotifier {
  final Ref ref;
  bool doctorsLoading = false;
  List<Doctor> doctors = [];
  MainPageController(this.ref);
  fetchAllDoctors(BuildContext context) async {
    // make api call
    final responseOrError = await ref.read(patientApiProvider).getAllDoctors();
    responseOrError.fold(
      (errorMsg) => showCustomSnackBar(context, errorMsg),
      (response) {
        // print("controller get all doctore --> ${response.body}");
        final myResponse = ResponseApi.fromJson(response.body);
        doctors = myResponse.doctors!;
        notifyListeners();
          print("this is list of doctors ${myResponse.doctors}"); 
            myResponse.doctors!.forEach((doctor){
              print(doctor.clinic.clinic_name);
            });
      }
      
    );
  }

  copyWith (bool? boctorsLoading ){
    this.doctorsLoading = boctorsLoading ?? this.doctorsLoading;
    notifyListeners();
  }
}

final mainPageControllerProvider =
    ChangeNotifierProvider((ref) => MainPageController(ref));
