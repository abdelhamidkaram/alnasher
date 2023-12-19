import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/core/app_colors.dart';
import 'package:listingapp/model/home_model.dart';

class CatsItemBuilder extends StatelessWidget {
  final HomeCategory homeCategory;
  const CatsItemBuilder({
    super.key, required this.homeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 90.h,
      child:SizedBox(
        width: 75.w,
        height: 72.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 75.w,
                height: 85.h,
                decoration: ShapeDecoration(
                  image:  DecorationImage(
                    image: NetworkImage(homeCategory.image ?? "https://static.sayidaty.net/2023-02/217547.jpg"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 75.w,
                height: 85.h,
                decoration: ShapeDecoration(
                  color: const  Color(0x5621A5EF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Opacity(
                opacity: 0.50,
                child: Container(
                  width: 75.w,
                  height: 85.h,
                  decoration: ShapeDecoration(
                    color:  Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.h,
              right: 15.w,
              child: SizedBox(
                width: 75.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      homeCategory.name ?? '',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
