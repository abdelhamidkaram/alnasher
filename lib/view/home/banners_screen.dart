import 'package:alnsher/core/shared_widgets/img_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/core/api/api_endpoint_string.dart';
import 'package:alnsher/core/api/dio_helper.dart';
import 'package:alnsher/model/home_model.dart';

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
                      (index) => InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Colors.black.withOpacity(0.2),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Colors.white,
                                        icon: Icon(Icons.close),
                                      ),
                                      Image.network(bannerList[index].image!),
                                    ],
                                  ),
                                );
                              },
                            ),
                            child: ImgView(
                                url: bannerList[index].image,
                                boxFit: BoxFit.cover),
                          ))),
            ),
          ],
        ),
      ),
    );
  }
}
