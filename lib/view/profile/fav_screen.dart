import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import '../../core/shared_widgets/ads_item_builder.dart';
import '../../model/home_model.dart';
class MyFavScreen extends StatefulWidget {
  const MyFavScreen({super.key});

  @override
  State<MyFavScreen> createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
 @override
  void initState() {
    super.initState();
   HomeCubit.get(context).getAllFav();

 }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) => HomeCubit(),
      builder: (context, state) {
        List<Ad> fav = HomeCubit.get(context).favs;
        return Scaffold(
            appBar: AppBar(title: const Text( 'المفضلة' ),),
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
                fav.map((e) => AdsItemBuilder(ad: e)).toList(),
              ),
            ));
      },
    );
  }
}
