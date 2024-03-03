import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/shared_widgets/ads_item_builder.dart';
import 'package:alnsher/model/home_model.dart';
import '../../core/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Ad> filteredItems = [];

  @override
  void initState() {
    filteredItems = HomeCubit.get(context).ads;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void filterItems(String query) {
      if(query.isNotEmpty){
        setState(() {
          filteredItems = filteredItems
              .where((item) =>
              item.title!.contains(query))
              .toList();
        });
      }else{
        setState(() {
          filteredItems = HomeCubit.get(context).ads;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Column(children:[
          Padding(
            padding:  EdgeInsets.all(16.0.h),
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: BorderSide(
                   color: AppColors.primaryColor
                  )
                ) ,
                hintText: 'ابحث هنا باسم المنتج .. '
              ),
              onChanged: (value){
                filterItems(value);
              },

            ),
          ),
          filteredItems.isNotEmpty
              ? GridView.count(
            shrinkWrap: true,
            physics: const PageScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            padding: EdgeInsets.all(16.w),
            crossAxisSpacing: 10.w,
            children:
            filteredItems.map((e) => AdsItemBuilder(ad: e)).toList(),
          )
              : const Text('لا يوجود نتائج بحث'),
        ] ),
      )
    );
  }
}
