import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/bloc/route/app_route.dart';
import 'package:listingapp/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:listingapp/core/app_colors.dart';
import 'package:listingapp/core/shared_pref/app_shared_preferences.dart';
import 'package:listingapp/core/shared_widgets/custom_button.dart';
import 'package:listingapp/core/utils/app_string.dart';
import 'package:listingapp/core/utils/assets_manger.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLogin = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagesManger.logo,
              height: 100.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 100.h,
            ),
            Builder(
              builder: (context) {
                AppSharedPreferences.isLogin().then((value){
                  isLogin = value ;
                });
                if (isLogin) {
                  return Builder(
                    builder: (context) {
                      Future.delayed(
                        const Duration(seconds: 3),
                            () {
                          goTo(
                              path: AppRouteStrings.home,
                              context: context,
                              replacement: true,
                              args: NoArgs());
                        },
                      );
                      return const CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.green,
                      );
                    },
                  );
                } else {
                  return Column(
                    children: [
                      CustomButton(
                          text: AppStrings.login,
                          onTap: () {
                            goTo(
                                path: AppRouteStrings.login,
                                context: context,
                                replacement: false,
                                args: NoArgs());
                          }),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomButton(
                        text: AppStrings.signUp,
                        onTap: () {
                          goTo(
                              path: AppRouteStrings.register,
                              context: context,
                              replacement: false,
                              args: NoArgs());
                        },
                        noColor: true,
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

