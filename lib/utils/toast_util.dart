import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    {required String msg,
    Toast? toastLength,
    int timeInSecForIosWeb = 1,
    double? fontSize = 16,
    ToastGravity? gravity = ToastGravity.CENTER,
    Color? backgroundColor,
    Color? textColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    timeInSecForIosWeb: timeInSecForIosWeb,
    fontSize: fontSize,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
