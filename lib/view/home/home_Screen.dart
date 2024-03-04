import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/model/home_model.dart';
import 'package:alnsher/view/categories/categpries_screen.dart';
import 'package:alnsher/view/home/create_ad.dart';
import 'package:alnsher/view/home/widgets/ads_slider.dart';
import 'package:alnsher/view/profile/profile_screen.dart';
import 'package:alnsher/view/search/search_screen.dart';
import '../../core/shared_pref/app_shared_preferences.dart';
import '../../core/shared_widgets/ads_item_builder.dart';
import '../../core/shared_widgets/custom_app-bar.dart';
import '../../core/shared_widgets/cats_item_builder.dart';
import '../../core/shared_widgets/custom_bottom_nav_bar.dart';
import 'banners_screen.dart';

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
    List<Widget> screens = [
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
      const BannersScreen(),
      const CreateAd() ,
      const SearchScreen(),
      const ProfileScreen(),
    ];
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) => HomeCubit(),
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () =>
              HomeCubit.get(context).getHomeResponse().whenComplete(() {
            setState(() {});
          }),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return BlocListener<HomeCubit, HomeState>(
                listener: (context, state) => HomeCubit(),
                child: Scaffold(
                  appBar: customAppBar(),
                  bottomNavigationBar: const CustomBottomNavBar(),
                  body: screens[HomeCubit.get(context).currentIndex],
                ),
              );
            },
          ),
        );
      },
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
        Container(
          height: 100.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                (cats.length > 12) ? 12 : cats.length,
                (index) => CatsItemBuilder(
                      index: index,
                      homeCategory: cats[index],
                    )),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Categories(),
                  ));
            },
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
