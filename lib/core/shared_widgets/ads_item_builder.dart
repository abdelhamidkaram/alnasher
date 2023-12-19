import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/bloc/route/app_route.dart';
import 'package:listingapp/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:listingapp/bloc/route/navigator_args/single_post_navigation_args.dart';
import 'package:listingapp/core/app_colors.dart';
import 'package:listingapp/core/utils/assets_manger.dart';
import 'package:listingapp/model/home_model.dart';

class AdsItemBuilder extends StatefulWidget {
  final Ad ad;

  const AdsItemBuilder({
    super.key,
    required this.ad,
  });

  @override
  State<AdsItemBuilder> createState() => _AdsItemBuilderState();
}

class _AdsItemBuilderState extends State<AdsItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goTo(
          path: AppRouteStrings.singlePost,
          context: context,
          replacement: false,
          args: SinglePostNavigationArgs(ad: widget.ad)),
      child: Container(
        width: 210.w,
        height: 192.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          image: DecorationImage(
            image: Image.network(widget.ad.mainImage?.image ??
                    'https://via.placeholder.com/169x172')
                .image,
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.grey.withOpacity(0.2) , width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 8.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  child: Image.asset(
                ImagesManger.favIcon,
                width: 20.w,
                height: 20.w,
                    color: AppColors.grey,
              )),
              BlurryContainer(
                blur: 15,
                width: double.infinity,
                height: 55.h,
                elevation: 0,
                borderRadius: BorderRadius.circular(0),
                color: Colors.transparent,
                child: Center(child: Text(widget.ad.title ?? 'بدون عنوان' , style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold ,
                  color: AppColors.primaryColor
                ),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
