import 'package:alnsher/view/profile/admin_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/core/api/dio_helper.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_pref/app_shared_preferences.dart';
import 'package:alnsher/core/utils/assets_manger.dart';

import '../../model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    AppSharedPreferences.getUser().then((value) => user = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(ImagesManger.myAds),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('اعلاناتي'),
          onTap: () => goTo(
              path: AppRouteStrings.myAds,
              context: context,
              replacement: false,
              args: NoArgs()),
        ),
        ListTile(
          leading: Image.asset(
            ImagesManger.favIcon,
            color: AppColors.primaryColor,
            height: 15,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('المفضلة'),
          onTap: () => goTo(
              path: AppRouteStrings.fav,
              context: context,
              replacement: false,
              args: NoArgs()),
        ),
        ListTile(
          leading: Image.asset(ImagesManger.policy),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('الشروط والأحكام'),
          onTap: () => goTo(
              path: AppRouteStrings.policy,
              context: context,
              replacement: false,
              args: NoArgs()),
        ),
        ListTile(
          leading: Image.asset(ImagesManger.aboutUs),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('من نحن '),
          onTap: () => goTo(
              path: AppRouteStrings.aboutUs,
              context: context,
              replacement: false,
              args: NoArgs()),
        ),
        ListTile(
          leading: Image.asset(ImagesManger.support),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text(' الدعم الفني '),
          onTap: () => goTo(
              path: AppRouteStrings.suport,
              context: context,
              replacement: false,
              args: NoArgs()),
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(12)),
          child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.primaryColor,
              ),
              title: const Text('تسحيل الخروج'),
              onTap: () => DioHelper.getData(endpoint: 'logout').then((value) {
                    HomeCubit.get(context)
                        .changeCurrentIndexForNavBar(0, context);
                    AppSharedPreferences.clear().then((value) {
                      goTo(
                          path: AppRouteStrings.home,
                          context: context,
                          replacement: true,
                          args: NoArgs());
                    });
                  })),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(12)),
          child: ListTile(
              leading: const Icon(
                Icons.person_off,
                color: AppColors.primaryColor,
              ),
              title: const Text('حذف الحساب'),
              onTap: () =>
                  DioHelper.getData(endpoint: 'deleteAccount').then((value) {
                    HomeCubit.get(context)
                        .changeCurrentIndexForNavBar(0, context);
                    AppSharedPreferences.clear().then((value) {
                      goTo(
                          path: AppRouteStrings.home,
                          context: context,
                          replacement: true,
                          args: NoArgs());
                    });
                  })),
        ),
        SizedBox(
          height: 15.h,
        ),
        user?.email == 'super@alnsher.com'
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(' لوحة الإدارة '),
                    onTap: (){
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPanel(),));
                    
                    }),
              )
            : SizedBox(),
      ],
    );
  }
}
