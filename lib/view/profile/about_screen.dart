import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/utils/assets_manger.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(HomeCubit.get(context).about == ''){
      HomeCubit.get(context).getAbout().then((value) => null);

    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('من نحن'),
          ),
          body: Center(
            child: Container(
              width: 352.w,
              height: 630.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF00A19A)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: SizedBox(
                height: 630.h,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('نبذة عنا',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.green)),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(ImagesManger.pin),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(HomeCubit.get(context).about),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
