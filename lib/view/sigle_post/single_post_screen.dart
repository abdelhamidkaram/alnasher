import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/bloc/home_bloc/home_cubit.dart';
import 'package:listingapp/core/app_colors.dart';
import 'package:listingapp/core/toasts.dart';
import 'package:listingapp/core/utils/assets_manger.dart';
import 'package:listingapp/model/home_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/single_bloc/single_cubit.dart';
import '../../core/shared_widgets/custom_app-bar.dart';

class SinglePostScreen extends StatefulWidget {
  final Ad ad;

  const SinglePostScreen({super.key, required this.ad});

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  CarouselController sliderController = CarouselController();
  int current = 0;
  bool? fav;

  @override
  void initState() {
    print('init ===========================================================');
    if (fav == null) {
      fav == widget.ad.fav!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SingleCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: BlocConsumer<SingleCubit, SingleState>(
        listener: (context, state) => SingleCubit(),
        builder: (context, state) {
          return Scaffold(
            appBar: customAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        carouselController: sliderController,
                        options: CarouselOptions(
                          height: 240.h,
                          initialPage: current,
                          onPageChanged: (index, reason) {
                            setState(() {
                              current = index;
                            });
                          },
                        ),
                        items: widget.ad.imageList!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image.network(i.image!).image,
                                      fit: BoxFit.cover),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                            return IconButton(
                                onPressed: () {
                                  SingleCubit.get(context)
                                      .changeFav(id: widget.ad.id!)
                                      .then((value) {
                                    setState(() {
                                      if (value != null) {
                                        fav = value.fav!;
                                      }
                                      HomeCubit.get(context).getHomeResponse();
                                    });
                                  });
                                },
                                icon: Image.asset(
                                  ImagesManger.favIcon,
                                  color:
                                      (fav != null && fav!) ? Colors.red : null,
                                ));
                          }),
                          ...List.generate(
                              widget.ad.imageList!.length,
                              (index) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: index == current
                                        ? Container(
                                            height: 8.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                          )
                                        : Container(
                                            height: 6.h,
                                            width: 15.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(2.r),
                                            ),
                                          ),
                                  ))
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 85.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                widget.ad.imageList!.length,
                                (index) => Container(
                                      width: 85.h,
                                      height: 85.h,
                                      margin: EdgeInsetsDirectional.all(10.h),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: Image.network(widget.ad
                                                    .imageList![index].image!)
                                                .image,
                                            fit: BoxFit.cover),
                                      ),
                                    )),
                          ),
                        ),
                        Text(widget.ad.title ?? '',
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          color: AppColors.greenLight,
                          child: Row(
                            children: [
                              Text(
                                widget.ad.expireAt ?? 'الثلاثاء 1 يناير 2024',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.ad.price ?? 'خاص',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: AppColors.green),
                                  ),
                                  Text(
                                    'KWD',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.green),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'تفاصيل اكثر',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const Text(
                            ''' موقع حيوي بـ الشروق في مربع الوزراء ، دقائق من مدينتي طلعت مصطفي
موقع حيوي بـ الشروق في
موقع حيوي بـ الشروق في مربع الوزراء ، دقائق من مدينتي طلعت مصطفي''',
                            maxLines: 5),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            widget.ad.whatsapp!.isEmpty
                                ? const SizedBox()
                                : contactButton(
                                    text: 'التواصل واتساب',
                                    onTap: () {
                                      whatsappUrl();
                                    },
                                    color: AppColors.green,
                                    width: 180.w,
                                  ),
                            widget.ad.phone!.isEmpty
                                ? const SizedBox()
                                : contactButton(
                                    text: 'التواصل هاتفيا',
                                    onTap: () {
                                      callUrl();
                                    },
                                    color: AppColors.primaryColor,
                                    width: 180.w,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget contactButton({text, onTap, width, color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 45.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: color ?? AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.green)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: (color != null) ? AppColors.white : null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  callUrl() async {
    var url = "tel:${widget.ad.whatsapp}";
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  whatsappUrl() async {
    var contact = widget.ad.phone ?? '01033232803';
    var androidUrl =
        "whatsapp://send?phone=$contact&text= مرحبا أريد التحدث معك حول اعلانك على منصة ناشر ";
    var iosUrl =
        "https://wa.me/$contact?text=${'مرحبا أريد التحدث معك حول اعلانك على منصة ناشر'}";

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      }
    } catch (e) {
      AppToasts.toastError(msg: 'خطأما .. أو أن واتساب غير مثبت على جهازك ');
      debugPrint(e.toString());
    }
  }
}
