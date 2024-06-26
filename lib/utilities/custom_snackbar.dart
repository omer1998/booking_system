import 'package:flutter/material.dart';

showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(color: Colors.black),),
    backgroundColor: Colors.white,
    
    behavior: SnackBarBehavior.floating,
  ));
}
