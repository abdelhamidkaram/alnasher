import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/login_bloc/login_cubit.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_widgets/custom_button.dart';
import 'package:alnsher/core/utils/app_string.dart';
import 'package:alnsher/core/utils/assets_manger.dart';
import '../../bloc/login_bloc/requsets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isValidEmail = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
                  BackButton(color: AppColors.primaryColor ),
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge),
                  Text('"', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
                  Text(AppStrings.app,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColors.green)),
                  Text('"', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              Text('قم بتسجيل الدخول حتي ترا جميع الاعلانات',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
              SizedBox(
                height: 35.h,
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
                height: 10.h,
              ),
              TextButton(
                onPressed: () {
                  goTo(
                      path: AppRouteStrings.resetPassword,
                      context: context,
                      replacement: false,
                      args: NoArgs());
                },
                child: const Text(
                  AppStrings.forgetPassword,
                  style: TextStyle(color: AppColors.green),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                onTap: () {
                  LoginCubit.get(context)
                      .getLogin(
                    context: context,
                      loginRequest: LoginRequest(
                          password: passwordController.text,
                          email: emailController.text))
                      .then((value)
                  {
                            // goTo(
                            //     path: AppRouteStrings.home,
                            //     context: context,
                            //     replacement: true,
                            //     args: NoArgs());
                          });
                },
                text: AppStrings.login,
                color: AppColors.primaryColor,
              ) ,

              TextButton(
                onPressed: () {
                  goTo(
                      path: AppRouteStrings.register,
                      context: context,
                      replacement: false,
                      args: NoArgs());
                },
                child: const Text(
                  'انشاء حساب جديد ',
                  style: TextStyle(color: AppColors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomField extends StatefulWidget {
  final TextInputType inputType;

  final String label;

  final IconData? suffixIcon;
  final int? minLines ;
  final bool isPassword;

  final bool isDisable;

  final TextEditingController controller;

  const CustomField({super.key,
    required this.inputType,
    required this.label,
    this.suffixIcon,
    this.isPassword = false,
    this.isDisable = false,
    this.minLines,
    required this.controller});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isValidEmail = false;
  bool passwordShow = false;

  @override
  void initState() {
    passwordShow = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailType = widget.inputType == TextInputType.emailAddress;
    return Container(
      height: widget.minLines == null ?  65.h : 150.h,
      padding: EdgeInsetsDirectional.only(start: 16.w),
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(12.r)),
      child: TextFormField(
        enabled: !widget.isDisable,
        onChanged: (value) {
          if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            setState(() {
              isValidEmail = true;
            });
          } else {
            if (isValidEmail) {
              setState(() {
                isValidEmail = false;
              });
            }
          }
        },
        keyboardType: widget.inputType,
        obscureText: passwordShow,
        controller: widget.controller,
        maxLines:widget.minLines ?? 1 ,
        decoration: InputDecoration(
          label:
          Text(widget.label, style: Theme
              .of(context)
              .textTheme
              .labelSmall),
          border: InputBorder.none,
          suffixIcon: Builder(builder: (context) {
            if (widget.suffixIcon == null &&
                !isEmailType &&
                !widget.isPassword) {
              return const SizedBox();
            } else if (widget.isPassword) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    passwordShow = !passwordShow;
                  });
                },
                child: Icon(
                  !passwordShow ? Icons.visibility : Icons.visibility_off,
                  color: !passwordShow ? AppColors.labelGrey : AppColors.green,
                ),
              );
            } else {
              return Icon(
                widget.suffixIcon ?? Icons.check_circle_outline,
                color: !isValidEmail ? AppColors.labelGrey : AppColors.green,
              );
            }
          }),
        ),
      ),
    );
  }
}
