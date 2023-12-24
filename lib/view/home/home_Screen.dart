import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/bloc/home_bloc/home_cubit.dart';
import 'package:listingapp/core/app_colors.dart';
import 'package:listingapp/model/home_model.dart';
import 'package:listingapp/view/home/widgets/ads_slider.dart';
import '../../core/shared_widgets/ads_item_builder.dart';
import '../../core/shared_widgets/custom_app-bar.dart';
import '../../core/shared_widgets/cats_item_builder.dart';
import '../../core/shared_widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<HomeCategory> cats = HomeCubit.get(context).categories;
    List<Ad> ads = HomeCubit.get(context).ads;
    List<HomeBanner> banners = HomeCubit.get(context).banners;
    return Scaffold(
      appBar: customAppBar(),
      bottomNavigationBar:  const CustomBottomNavBar(),
      body: PageView(
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        controller:HomeCubit.get(context).pageController,
        onPageChanged: (value) =>
            setState(() {
              HomeCubit.get(context).changeCurrentIndexForNavBar(value);
            }),
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bannerView(banners),
                      titleView(),
                      SizedBox(
                        height: 5.h,
                      ),
                      categoriesListView(cats),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 192.h,
                        child: adsListView(ads),
                      ),
                      ...List.generate(
                          cats.length,
                          (index) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleView(title: cats[index].name),
                                  SizedBox(
                                    height: 192.h,
                                    child: adsListView(cats[index].ads!),
                                  ),
                                ],
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Text('data11'),
          const Text('data1222'),
          const Text('data1333'),
          const Text('data114444'),
        ],
      ),
    );
  }

  ListView adsListView(List<Ad> ads) {
    return ListView.separated(
      itemCount: ads.length,
      itemBuilder: (context, index) => AdsItemBuilder(ad: ads[index]),
      separatorBuilder: (context, index) => SizedBox(
        width: 10.w,
      ),
      scrollDirection: Axis.horizontal,
    );
  }

  Padding titleView({title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Text(
        title ?? 'بعض الأقسام المقترحة ',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.grey),
      ),
    );
  }

  SizedBox bannerView(List<HomeBanner> banners) {
    return SizedBox(
      width: double.infinity,
      height: 120.h,
      child: AdsSlider(banners),
    );
  }

  Column categoriesListView(List<HomeCategory> cats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          runSpacing: 10,
          children: List.generate(
              (cats.length > 12) ? 12 : cats.length,
              (index) => CatsItemBuilder(
                    homeCategory: cats[index],
                  )),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              ' عرض جميع الأقسام... ',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.sp),
            )),
      ],
    );
  }
}
