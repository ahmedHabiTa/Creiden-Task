import 'package:creiden/features/core/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
