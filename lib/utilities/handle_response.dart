import "dart:convert";

import "package:booking_system/models/api/response.dart";
import "package:booking_system/utilities/routes.dart";
import "package:flutter/cupertino.dart";
import "package:http/http.dart " as http;

import "../views/share_widgets/show_dialogue.dart";

handleResponse(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess,
    // VoidCallback? onSuccessAction,
    // String? onSuccessActionName
    }) {
  print("------------response --> ${json.decode(response.body)}");
  print(
      "------------user --> ${json.decode(response.body)["user"].runtimeType}");
  // if (response == null) return;
  final myResponse = ResponseApi.fromMap(json.decode(response.body));

  print("myResponse user --> ${myResponse.user}");
  if (response.statusCode == 200) {
    onSuccess();
    if(myResponse.token != null){
      print("token --> ${myResponse.token}");
    }
    // showMyDialog(context, myResponse.msg, onSuccessAction, onSuccessActionName);
    // onSuccessAction();
  } else {
    showMyDialog(context, myResponse.msg);
  }
}

// onSuccess(BuildContext context){
//   sho
// }