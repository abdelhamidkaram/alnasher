import 'dart:io';

import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_widgets/img_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/core/api/api_endpoint_string.dart';
import 'package:alnsher/core/api/dio_helper.dart';
import 'package:alnsher/model/home_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/toasts.dart';
import '../../core/utils/assets_manger.dart';

List<HomeBanner> bannerList = [];

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  @override
  Widget build(BuildContext context) {
    if (bannerList.isEmpty) {
      DioHelper.getData(endpoint: ApiEndPoints.banner).then((value) {
        if (bannerList.isEmpty) {
          DioHelper.getData(endpoint: ApiEndPoints.banner).then((value) {
            setState(() {
              List response = value.data['data_response']['banner'];
              for (var element in response) {
                if (element['des'] == 'banner2') {
                  var ele = HomeBanner.fromJson(element);
                  bannerList.add(ele);
                }
              }
            });
          });
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(3.0),
              sliver: SliverGrid.count(
                  mainAxisSpacing: 15.w, //horizontal space
                  crossAxisSpacing: 25.h, //vertical space
                  crossAxisCount: 2, //number of images for a row
                  children: List.generate(
                      bannerList.length,
                      (index)
                      {
                       var  banner = bannerList[index];

                       Widget contactButton({text, onTap, width, color, imgUrl}) {
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
                                   Image.asset(imgUrl , color: Colors.white , height: 25.h ),
                                   SizedBox(width: 10.w,),
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
                         var url = "tel:${banner.whatsapp}";
                         try {
                           if (await canLaunchUrl(Uri.parse(url))) {
                             await launchUrl(Uri.parse(url));
                           }
                         } catch (e) {
                           debugPrint(e.toString());
                         }
                       }

                       whatsappUrl() async {
                         var contact = banner.phone;
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


                            return InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => Container(
                                  color:
                                      AppColors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(

                                        children: [
                                          BackButton(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 700.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ListView(
                                            children: [
                                              Image.network(banner.image!),
                                              Text(banner.description?? '' , style: Theme.of(context).textTheme.bodyMedium),
                                              SizedBox(height: 30.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  (banner.whatsapp == null)
                                                      ? const SizedBox()
                                                      : contactButton(
                                                    imgUrl: ImagesManger.whatsapp,
                                                    text: 'الواتساب',
                                                    onTap: () {
                                                      whatsappUrl();
                                                    },
                                                    color: AppColors.green,
                                                    width: 180.w,
                                                  ),
                                                  (banner.phone == null)
                                                      ? const SizedBox()
                                                      : contactButton(
                                                    imgUrl: ImagesManger.phone,
                                                    text: 'الهاتف',
                                                    onTap: () {
                                                      callUrl();
                                                    },
                                                    color: AppColors.primaryColor,
                                                    width: 180.w,
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              child: ImgView(
                                  url: bannerList[index].image,
                                  boxFit: BoxFit.cover),
                            );



                          })),
            ),
          ],
        ),
      ),
    );
  }

}
