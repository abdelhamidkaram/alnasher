import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_widgets/ads_item_builder.dart';
import 'package:alnsher/core/shared_widgets/custom_app-bar.dart';

class Categories extends StatefulWidget {
  final int  current;
  const Categories({super.key , this.current= 0});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late int currentCats ;
  @override
  void initState() {
    super.initState();
    currentCats = widget.current;
}
  @override
  Widget build(BuildContext context) {
    var cats = HomeCubit.get(context).categories;

    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              color: AppColors.grey,
              width: double.infinity,
              height: 50.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    cats.length,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentCats = index;
                                });
                              },
                              child: Text(
                                cats[index].name ?? 'عام',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                  shadows: [
                                    Shadow(
                                        color: currentCats == index
                                            ? AppColors.green
                                            : AppColors.primaryColor,
                                        offset: Offset(0, -8.h))
                                  ],
                                  color: Colors.transparent,
                                  fontSize: 14.sp,
                                  decoration: currentCats == index
                                      ? TextDecoration.underline
                                      : null,
                                  decorationColor: AppColors.green,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationThickness: 2.sp,
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.count(
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                padding: EdgeInsets.all(16.w),
                crossAxisSpacing: 10.w,
                children:
                cats[currentCats].ads!.map((e) => AdsItemBuilder(ad: e)).toList(),
              ),
              ),

          ],
        ),
      ),
    );
  }
}
