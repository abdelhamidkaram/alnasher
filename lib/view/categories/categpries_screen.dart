import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/core/shared_widgets/cats_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_widgets/ads_item_builder.dart';
import 'package:alnsher/core/shared_widgets/custom_app-bar.dart';

class Categories extends StatefulWidget {
  final int current;
  final int currentSub;

  const Categories({super.key, this.current = 0, this.currentSub = 0});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late int mainCurrentCats;

  late int currentSubCats;
  late bool showMainAds;

  @override
  void initState() {
    super.initState();
    mainCurrentCats = widget.current;
    currentSubCats = widget.currentSub;
    showMainAds = true;
  }

  @override
  Widget build(BuildContext context) {
    var allCats = HomeCubit.get(context).categories;
    var mainCats = allCats.where((ele) => ele.isSubCategory == false).toList();
    var subCats = allCats.where((ele) => ele.isSubCategory == true).toList();


    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => goTo(path: AppRouteStrings.home, context: context, replacement: true,    args: NoArgs()),
      child: Scaffold(
        appBar: customAppBar(),
        body: allCats.isNotEmpty ? SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 100.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                       mainCats.length,
                      (index) => CatsItemBuilder(
                            index: index,
                            homeCategory: mainCats[index],
                          )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                color: AppColors.grey,
                width: double.infinity,
                height: 50.h,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showMainAds = true;
                            });
                          },
                          child: Text(
                            'كل اعلانات : ${mainCats[mainCurrentCats].name}',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                              shadows: [
                                Shadow(
                                    color: showMainAds == true
                                        ? AppColors.green
                                        : AppColors.primaryColor,
                                    offset: Offset(0, -8.h))
                              ],
                              color: Colors.transparent,
                              fontSize: 14.sp,
                              decoration: showMainAds == true
                                  ? TextDecoration.underline
                                  : null,
                              decorationColor: AppColors.green,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 2.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                        subCats.length,
                            (index) => subCats[index].mainCat!.id == mainCats[mainCurrentCats].id?
                            Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentSubCats = index;
                                  showMainAds = false;
                                });
                              },
                              child: Text(
                                subCats[index].name ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                  shadows: [
                                    Shadow(
                                      color: (currentSubCats == index && !showMainAds)
                                          ? AppColors.green
                                          : AppColors.primaryColor,
                                      offset: Offset(0, -8.h),
                                    )
                                  ],
                                  color: Colors.transparent,
                                  fontSize: 14.sp,
                                  decoration: (currentSubCats == index && !showMainAds)
                                      ? TextDecoration.underline
                                      : null,
                                  decorationColor: AppColors.green,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationThickness: 2.sp,
                                ),
                              ),
                            ),
                          ),
                        ):SizedBox()),
                  ],
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
                  children: showMainAds == true
                      ? mainCats[mainCurrentCats].ads!
                          .map((e) => AdsItemBuilder(ad: e))
                          .toList()
                      : subCats.isNotEmpty? subCats[currentSubCats]
                          .ads!
                          .map((e) => AdsItemBuilder(ad: e))
                          .toList() : HomeCubit.get(context).ads.map((e) => AdsItemBuilder(ad: e))
                      .toList(),
                ),
              ),
            ],
          ),
        ) : Center(child: Text('لا يوجد اعلانات'),),
      ),
    );
  }
}
