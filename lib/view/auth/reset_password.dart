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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isSender = true;
  var codeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var emailController = TextEditingController();

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
                controller: emailController,
                isDisable: !isSender,
              ),
              SizedBox(
                height: 25.h,
              ),
              !isSender
                  ?  Column(
                      children: [

                        CustomField(
                          inputType: TextInputType.text,
                          label: AppStrings.enterCode,
                          controller: codeController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomField(
                          inputType: TextInputType.visiblePassword,
                          label: AppStrings.password,
                          controller: passwordController,
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomField(
                          inputType: TextInputType.visiblePassword,
                          label: AppStrings.confirmPassword,
                          controller: confirmPasswordController,
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ):const SizedBox(),
              CustomButton(
                  color: AppColors.primaryColor,
                  text: !isSender ? AppStrings.send : AppStrings.sendCode,
                  onTap: isSender
                      ? () {
                          LoginCubit.get(context)
                              .getSendCodForResetPassword(
                                  email: emailController.text)
                              .then((value) {
                            setState(() {
                              isSender = !isSender;
                            });
                          });
                        }
                      : () {
                          LoginCubit.get(context).getResetPassword(
                            resetPasswordRequest: ResetPasswordRequest(
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                              email: emailController.text,
                              code: codeController.text,
                            ),
                          ).then((value) => goTo(path: AppRouteStrings.login, context: context, replacement: true, args: NoArgs()));
                        }),
            ],
          ),
        ),
      ),
    );
  }
}
