import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/api/dio_helper.dart';
import 'package:alnsher/core/shared_widgets/ads_item_builder.dart';
import 'package:alnsher/model/home_model.dart';
class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {

@override
  void initState() {
    super.initState();
    HomeCubit.get(context).getAllMyAds().then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: Text( 'إعلاناتي' ),),
      body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: GridView.count(
    shrinkWrap: true,
    physics: const PageScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 10.h,
    padding: EdgeInsets.all(16.w),
    crossAxisSpacing: 10.w,
    children:
    HomeCubit.get(context).myAds.map((e) => AdsItemBuilder(ad: e)).toList(),
    ),
    ));
  },
);
  }
}
