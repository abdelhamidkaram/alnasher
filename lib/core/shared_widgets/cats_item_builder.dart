import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/view/categories/categpries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/model/home_model.dart';

class CatsItemBuilder extends StatelessWidget {
  final HomeCategory homeCategory;
  final index;

  const CatsItemBuilder({
    super.key,
    required this.homeCategory,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(current: index,),
          )),
      child: Container(
        width: 90.h,
        height: 90.h,
        child: Column(children: [
          Container(
            width: 70.h,
            height: 70.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(homeCategory.image!) , fit: BoxFit.contain),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor,
              )

            ),
          ) , 
          Text(homeCategory.name!, style: TextStyle(
            fontSize: 12.sp,

          ),
          maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ]),
      ),
    );
  }
}
