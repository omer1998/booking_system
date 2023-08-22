
import 'package:booking_system/views/booking/booking_page_test.dart';
import 'package:booking_system/views/pages/auth/patient_page/sign_in/p_sign_in_page.dart';
import 'package:booking_system/views/pages/doctor/doctor_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../views/pages/auth/doctor_page/setup.dart';
import '../views/pages/auth/patient_page/sign_up/p_sign_up_page.dart';
import '../views/pages/main/main_page.dart';
import '../views/pages/auth_old/chat_page.dart';
import '../views/pages/auth_old/log_in.dart';
import '../views/pages/auth_old/login.dart';
import '../views/pages/auth_old/sign_up.dart';


class Routes{
  static const home = '/';
  static const login = '/login';
  static const patientSignUp = '/patient_sign_up';
  static const patientSignIn = '/patient_sign_in';
  static const chatPage = "/chat_page";
  // for patients
  static const mainPage= '/main_page';
  static const bookingPage = '/booking_page';
  static const doctorPage = '/doctor_page';

  // for doctors
  static const doctorSetup = "/doctor-setup";



// for doctors
  

}

 onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const MyHomePage(title: '',));
    case Routes.login:
      return MaterialPageRoute(builder: (_) =>  const Login());
    case Routes.patientSignUp:
      return MaterialPageRoute(builder: (_) => const PatientSignUpPage());
    case Routes.patientSignIn:
      return MaterialPageRoute(builder: (_) => const PatientSignInPage());
    case Routes.chatPage:
      return MaterialPageRoute(builder: (_) => const ChatPage());
    case Routes.mainPage:
      return MaterialPageRoute(builder: (_) => const MainPage());
    case Routes.bookingPage:
      return MaterialPageRoute(builder: (_) => const BookingScreen());
      case Routes.doctorPage:
        return MaterialPageRoute(builder: (_) => const  DoctorPage());
      case Routes.doctorSetup:
        return MaterialPageRoute(builder: (_) => const DoctorSetupPage());
    default:
      return MaterialPageRoute(builder: (_) => const MyHomePage(title: '',));
  }
}