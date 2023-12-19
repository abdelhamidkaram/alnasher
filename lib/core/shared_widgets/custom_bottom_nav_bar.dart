import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/bloc/home_bloc/home_cubit.dart';
import '../app_colors.dart';
import '../utils/assets_manger.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) => HomeCubit(),
      child: BottomNavigationBar(
        onTap: (value) =>
            HomeCubit.get(context).changeCurrentIndexForNavBar(value),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.homeIcon,
              color:
              currentIndex == 0 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.adsIcon,
              color:
              currentIndex == 1 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'الاعلانات',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.addIcon,
              color:
              currentIndex == 2 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'اضافة اعلان',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.searchIcon,
              color:
              currentIndex == 3 ? AppColors.green : AppColors.primaryColor,
              width: 24.h,
              height: 24.h,
            ),
            label: 'بحث',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagesManger.account,
              color:
              currentIndex == 4 ? AppColors.green : AppColors.primaryColor,
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
