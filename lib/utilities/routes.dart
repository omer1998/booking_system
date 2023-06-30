
import 'package:booking_system/views/booking/booking_page_test.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../views/pages/main/main_page.dart';
import '../views/pages/auth/chat_page.dart';
import '../views/pages/auth/log_in.dart';
import '../views/pages/auth/login.dart';
import '../views/pages/auth/sign_up.dart';


class Routes{
  static const home = '/';
  static const login = '/login';
  static const signUp = '/sign_up';
  static const signIn = '/sign_in';
  static const chatPage = "/chat_page";
  static const mainPage= '/main_page';
  static const bookingPage = '/booking_page';
  

}

 onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const MyHomePage(title: '',));
    case Routes.login:
      return MaterialPageRoute(builder: (_) =>  const Login());
    case Routes.signUp:
      return MaterialPageRoute(builder: (_) => const SignUp());
    case Routes.signIn:
      return MaterialPageRoute(builder: (_) => const MyLogIn());
    case Routes.chatPage:
      return MaterialPageRoute(builder: (_) => const ChatPage());
    case Routes.mainPage:
      return MaterialPageRoute(builder: (_) => const MainPage());
    case Routes.bookingPage:
      return MaterialPageRoute(builder: (_) => const BookingScreen());
    default:
      return MaterialPageRoute(builder: (_) => const MyHomePage(title: '',));
  }
}