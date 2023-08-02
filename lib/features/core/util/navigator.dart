import 'package:flutter/material.dart';

class AppNavigator {
  static Future<void> push(
      {required BuildContext context, required Widget screen}) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  static Future<void> pushReplacement(
      {required BuildContext context, required Widget screen}) async {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  static dynamic pop({required BuildContext context, dynamic object}) {
    return Navigator.of(context).pop<dynamic>(object);
  }

  static dynamic popToFrist({required BuildContext context, dynamic object}) {
    return Navigator.of(context).popUntil((rout) => rout.isFirst);
  }

  // static dynamic popToLeeTaxi({required BuildContext context, dynamic object}) {
  //   return Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => const NotificationsHandler()),
  //       (Route<dynamic> route) => false);
  // }
}
