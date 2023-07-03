

import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../service/auth.dart';
import '../views/pages/auth/log_in.dart';

class AuthController with ChangeNotifier{
  String _email= "";
  String _password= "";
  AuthPageType pageAuthType = AuthPageType.login;
  bool _isLoading = false;
  // now create a function to set values for email and password that are captured from the form
  void setEmail(email){
    _email = email;
    notifyListeners();
  }

  void setPassword(password){
    _password = password;
    notifyListeners();
  }

  get isLoading => _isLoading;
  
  set loading(bool loading){
    _isLoading = loading;
    notifyListeners();
  }

  void Loading(bool loading){
    _isLoading = loading;
    notifyListeners();
  }
  get email => _email;
  get password => _password;

  MyFirebaseAuth firebaseAuth = MyFirebaseAuth();
 

  
  void changePageAuthType(){
    if(pageAuthType == AuthPageType.login){
      pageAuthType = AuthPageType.register;
    }
    else{
      pageAuthType = AuthPageType.login;
    }
    notifyListeners();
  }
Future signIn() async{
  await firebaseAuth.signIn(_email, _password);
}
Future signUp() async{
  await firebaseAuth.signUp(_email, _password);
}
Future submit() async{
  if(pageAuthType == AuthPageType.login){
    // login
    try{
        await firebaseAuth.signIn(_email, _password);
    } on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        throw "No user found for that email";
      }
      else if(e.code == "wrong-password"){
        throw "Wrong password provided for that user";
      }
  }
  }
  else{
    // register
    try{
          await firebaseAuth.signUp(_email, _password);

    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        throw "The account already exists for that email";
      } else if(e.code == 'weak-password'){
        throw "The password provided is too weak";
      }
    }

  }
}

}
