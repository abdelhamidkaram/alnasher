import 'package:alnsher/core/shared_widgets/img_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/model/home_model.dart';
import '../../../core/app_colors.dart';

class AdsSlider extends StatefulWidget {
  final List<HomeBanner> banners;

  const AdsSlider(
    this.banners, {
    super.key,
  });

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  int current = 0 ;

@override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        PageView.builder(
          itemCount: widget.banners.length,
          onPageChanged: (value) {
            setState(() {

              current = value ;

            });
          },
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
            child: ImgView(url: widget.banners[index].image!),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              widget.banners.length
              , (i) => Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w),
            child: current == i ? Container(
              height: 8.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(5.r),
              ),
            ):Container(
              height: 6.h,
              width: 15.w,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
