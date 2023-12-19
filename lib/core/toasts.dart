import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class AppToasts {
  static toast({
    required String msg,
  }) =>
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 14.sp
  );

  static toastError({
    required String msg,
  }) {

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.sp
    );
    hideLoading();
  }


  static toastLoading() {
    EasyLoading.instance.backgroundColor = Colors.transparent;
    EasyLoading.instance.boxShadow = [];
    EasyLoading.show(
      dismissOnTap: false,
      indicator: const CircularProgressIndicator.adaptive(),
    );
  }
  static hideLoading() {
    EasyLoading.dismiss();
  }

  static toastSuccess({required String msg}) =>
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 14.sp
      );}
