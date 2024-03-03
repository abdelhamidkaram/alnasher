import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/core/api/dio_helper.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_widgets/custom_button.dart';
import 'package:alnsher/model/home_model.dart';
import 'package:alnsher/view/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/toasts.dart';

class SuportScreen extends StatefulWidget {
  const SuportScreen({super.key});

  @override
  State<SuportScreen> createState() => _SuportScreenState();
}

class _SuportScreenState extends State<SuportScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الدعم الفني '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              CustomField(
                  inputType: TextInputType.name,
                  label: 'الأسم',
                  controller: nameController),
              SizedBox(
                height: 20.h,
              ),
              CustomField(
                  inputType: TextInputType.emailAddress,
                  label: 'البريد الإلكتروني ',
                  controller: emailController),
              SizedBox(
                height: 20.h,
              ),
              CustomField(
                inputType: TextInputType.multiline,
                label: 'رسالتك ',
                controller: messageController,
                minLines: 5,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: 'ارسال',
                onTap: () {
                  DioHelper.postData(endpoint: 'contact', body: {
                    'name': nameController.text,
                    'email': emailController.text,
                    'phone': '', //Todo:
                    'des': messageController.text
                  }).then((value) {
                    AppToasts.toastSuccess(msg: 'تم ارسال رسالتك بنجاح ');
                  }).catchError((e) => AppToasts.toastError(msg: e.toString()));

                  nameController.clear();
                  emailController.clear();
                  messageController.clear();
                },
                color: AppColors.primaryColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextButton(
                onPressed: whatsappUrl,
                child: Text('تواصل معنا عبر واتساب',
                    style: TextStyle(
                        color: AppColors.green,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  whatsappUrl() async {
    var contact = '+96555992062'; //TODO: change this to customer number
    var androidUrl =
        "whatsapp://send?phone=$contact&text= اتواصل معك بخصوص مشكلة في تطبيق الناشر  ";
    var iosUrl =
        "https://wa.me/$contact?text=${'اتواصل معك بخصوص مشكلة في تطبيق الناشر '}";

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      }
    } catch (e) {
      AppToasts.toastError(msg: 'خطأما .. أو أن واتساب غير مثبت على جهازك ');
      debugPrint(e.toString());
    }
  }
}
