import 'package:creiden/core/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String? message) {
  Fluttertoast.showToast(
      backgroundColor: blackColor,
      textColor: white,
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2);
}

showToastSuccess(String? message) {
  Fluttertoast.showToast(
      backgroundColor: Colors.greenAccent,
      textColor: white,
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2);
}

showToastError(String? message) {
  Fluttertoast.showToast(
      backgroundColor: Colors.redAccent,
      textColor: white,
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2);
}
