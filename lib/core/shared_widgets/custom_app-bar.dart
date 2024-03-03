import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_pref/app_shared_preferences.dart';
import 'package:alnsher/core/utils/app_string.dart';
import 'package:alnsher/core/utils/assets_manger.dart';
import 'package:alnsher/model/user_model.dart';

PreferredSizeWidget customAppBar() {
  return PreferredSize(
    preferredSize: Size(double.infinity, 125.h),
    child: const AppBarContent(),
  );
}

class AppBarContent extends StatefulWidget {
  const AppBarContent({
    super.key,
  });

  @override
  State<AppBarContent> createState() => _AppBarContentState();
}

class _AppBarContentState extends State<AppBarContent> {
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leadingWidth: 140.w,
          leading: Center(
            child: Builder(
                builder: (context) {
                  AppSharedPreferences.getUser().then((value) {
                    setState(() {
                      user = value;
                    });
                  });
                  return Text(
                    '${AppStrings.welcome} ${user?.firstName ?? ''}',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  );
                }
            ),
          ),
          actions: [

          ],
        ),
        GestureDetector(
          onTap: () {
            goTo(path: AppRouteStrings.search,
                context: context,
                replacement: false,
                args: NoArgs()
            );
          },
          child: Container(
              color: AppColors.primaryColor,
              width: double.infinity,
              height: 65.h,
              padding: EdgeInsetsDirectional.only(bottom: 20.h),
              child: Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 10.w, start: 20.w),
                  child: Row(
                    children: [
                      Text(AppStrings.searchHint, style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700
                      )),
                      const Spacer(),
                      const Icon(Icons.search, color: AppColors.textGrey)
                    ],
                  ),
                ),
              )),
        )
      ],
    );
  }
}
