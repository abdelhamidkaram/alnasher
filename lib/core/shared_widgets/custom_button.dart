import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listingapp/core/app_colors.dart';

class CustomButton extends StatefulWidget {
  final Color? color;

  final String text;

  final double? width;

  final bool noColor;

  final VoidCallback onTap;
  final Widget? icon ;

  const CustomButton(
      {super.key,
        required this.text,
        required this.onTap,
        this.color,
        this.width,
        this.noColor = false,
        this.icon});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? double.infinity,
        height: 65.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: widget.noColor ? null : widget.color ?? AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border:
            !widget.noColor ? null : Border.all(color: AppColors.green)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: (widget.noColor || widget.color!=null )?AppColors.white:null
                ),

              ),
              SizedBox(width: 8.w,),
              widget.icon?? const  SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
