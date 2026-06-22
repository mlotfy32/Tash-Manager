import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  factory Helper() {
    return _help;
  }
  Helper._internal();
  static final Helper _help = Helper._internal();

  static void flutterToast({required String message}) {
Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.TOP,
  timeInSecForIosWeb: 6,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 13.sp,
);
  }
}
