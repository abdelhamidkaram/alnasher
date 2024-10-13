import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/send_email_args.dart';

import '../../bloc/login_bloc/login_cubit.dart';
import '../../bloc/login_bloc/requsets.dart';
import '../../core/app_colors.dart';
import '../../core/shared_widgets/custom_button.dart';
import '../../core/utils/app_string.dart';
import '../../core/utils/assets_manger.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isValidEmail = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  BackButton(color: AppColors.primaryColor),
                ],
              ),
              Image.asset(ImagesManger.logoDark , width: 220.w,),
              SizedBox(
                height: 5.h,
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
              Text('قم بتسجيل حساب جديد حتي تتمكن من',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
              SizedBox(
                height: 14.h,
              ),
              Text('اضافة اعلانات وتصفح الاعلانات المعروضة',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
              SizedBox(
                height: 35.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 170.w,
                    child: CustomField(
                      inputType: TextInputType.name,
                      label: AppStrings.firstName,
                      controller: firstNameController,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 170.w,
                    child: CustomField(
                      inputType: TextInputType.name,
                      label: AppStrings.lastName,
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomField(
                inputType: TextInputType.emailAddress,
                label: AppStrings.email,
                controller: emailController,
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomField(
                inputType: TextInputType.visiblePassword,
                label: AppStrings.password,
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomField(
                inputType: TextInputType.visiblePassword,
                label: AppStrings.confirmPassword,
                controller: rePasswordController,
                isPassword: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onTap: () {
                  LoginCubit.get(context)
                      .getRegister(
                          registerRequest: RegisterRequest(
                        email: emailController.text,
                        password: passwordController.text,
                        rePassword: rePasswordController.text,
                        lastName: lastNameController.text,
                        firstName: firstNameController.text,
                      ))
                      .then((value) => goTo(
                          path: AppRouteStrings.verify,
                          context: context,
                          replacement: false,
                          args: SenderEmailSenderArgs(email: emailController.text)));
                },
                text: AppStrings.gotoConfirm,
                color: AppColors.primaryColor,
                icon: Image.asset(ImagesManger.login, height: 20),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
