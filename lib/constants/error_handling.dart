import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
required BuildContext buildContext,
required VoidCallback onSuccess,
}){
switch(response.statusCode){
  case 200:
    onSuccess();
    break;
  case 400:
    showSnackBar
}
}