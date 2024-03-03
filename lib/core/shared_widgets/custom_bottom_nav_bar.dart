import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import '../app_colors.dart';
import '../utils/assets_manger.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int current = HomeCubit.get(context).currentIndex;
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) => HomeCubit(),
      child: BottomNavigationBar(
        onTap: (value) => setState(() {
          if (value == 3) {
            current = value;
            goTo(
                path: AppRouteStrings.search,
                context: context,
                replacement: false,
                args: NoArgs());
          } else {
            current = value ;
            HomeCubit.get(context).changeCurrentIndexForNavBar(value , context);
          }
        }),
        currentIndex: current,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.homeIcon,
              color: current == 0 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.adsIcon,
              color: current == 1 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'الاعلانات',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.addIcon,
              color: current == 2 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'اضافة اعلان',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.searchIcon,
              color: current == 3 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'بحث',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.account,
              color: current == 4 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'الحساب',
          ),
        ],
      ),
    );
  }
}
