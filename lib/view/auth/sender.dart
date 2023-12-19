import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_colors.dart';
import '../../core/utils/app_string.dart';

class SenderEmailScreen extends StatefulWidget {
  const SenderEmailScreen({super.key});

  @override
  State<SenderEmailScreen> createState() => _SenderEmailScreenState();
}

class _SenderEmailScreenState extends State<SenderEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.welcomeTo,
                      style: Theme.of(context).textTheme.titleLarge),
                  Text('"', style: Theme.of(context).textTheme.titleLarge),
                  Text(AppStrings.app,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColors.green)),
                  Text('"', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              Text('قم بتسجيل حساب جديد حتي تتمكن من',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
              SizedBox(height: 14.h,),
              Text('اضافة اعلانات وتصفح الاعلانات المعروضة',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
    );
  }
}
