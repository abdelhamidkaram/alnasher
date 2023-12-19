import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/bloc/login_bloc/login_cubit.dart';
import 'package:listingapp/bloc/login_bloc/requsets.dart';
import 'package:listingapp/bloc/route/app_route.dart';
import 'package:listingapp/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:listingapp/core/app_colors.dart';
import 'package:listingapp/core/shared_widgets/custom_button.dart';
import 'package:listingapp/core/utils/app_string.dart';
import 'package:listingapp/core/utils/assets_manger.dart';
import 'package:listingapp/view/auth/login.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool isSender = true;
  var codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const Row(
                children: [
                  BackButton(color: AppColors.primaryColor),
                ],
              ),
              Image.asset(ImagesManger.logoDark, height: 100.h),
              SizedBox(
                height: 34.h,
                width: double.infinity,
              ),
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
              Text('قم بأدخال عنوان بريدك الالكتروني وسوف يتم ارسال',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
              SizedBox(
                height: 14.h,
              ),
              Text('رمز مكون من 4 اراقام',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
              SizedBox(
                height: 30.h,
              ),
              CustomField(
                inputType: TextInputType.emailAddress,
                label: AppStrings.email,
                controller: TextEditingController(text: widget.email),
                isDisable: true,
              ),
              SizedBox(
                height: 50.h,
              ),
              Column(
                children: [
                  isSender
                      ? CustomField(
                          inputType: TextInputType.text,
                          label: AppStrings.enterCode,
                          controller: codeController)
                      : const SizedBox(),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
              CustomButton(
                  color: AppColors.primaryColor,
                  text: isSender ? AppStrings.send : AppStrings.sendCode,
                  onTap: () {
                    LoginCubit.get(context)
                        .verifyCode(
                          verifyCodeRequest: VerifyCodeRequest(
                            email: widget.email,
                            code: codeController.text,
                          ),
                        )
                        .then((value) => goTo(
                            path: AppRouteStrings.home,
                            context: context,
                            replacement: true,
                            args: NoArgs()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
