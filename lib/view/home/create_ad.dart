import 'dart:convert';
import 'dart:io';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/core/shared_pref/app_shared_preferences.dart';
import 'package:alnsher/core/toasts.dart';
import 'package:alnsher/core/utils/constant.dart';
import 'package:alnsher/model/home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/core/api/dio_helper.dart';
import 'package:alnsher/core/app_colors.dart';
import 'package:alnsher/core/shared_widgets/custom_button.dart';
import 'package:alnsher/core/utils/assets_manger.dart';
import 'package:alnsher/view/auth/login.dart';

class CreateAd extends StatefulWidget {
  const CreateAd({super.key});

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  @override
  Widget build(BuildContext context) {
    return const AddProductImages();
  }
}

class AddProductImages extends StatefulWidget {
  const AddProductImages({Key? key}) : super(key: key);

  @override
  State<AddProductImages> createState() => _AddProductImagesState();
}

class _AddProductImagesState extends State<AddProductImages> {
  var formKey = GlobalKey<FormState>();
  List<File> _images = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();

  @override
  Widget build(BuildContext context) {

  if( AppSharedPreferences.TOKEN.isEmpty) {

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('يجب تسجيل حساب جديد او تسجيل الدخول من أجل نشر إعلاناتك '),
            SizedBox(height: 20.h,),
            CustomButton(
              onTap: (){
                goTo(path: AppRouteStrings.login, context: context, replacement: false, args: NoArgs());
              },
              text: 'تسجيل الدخول ',
              color: AppColors.primaryColor,
              width: 200.w,
            ),
          ],
        ),
      ),
    );
  }

    Future<void>
    _getImages() async {
      List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
        maxWidth: 800.w,
        maxHeight: 600.h,
        imageQuality: 80,
      );

      setState(() {
        _images = pickedImages.map((image) {
          print(image.path);
          return File(image.path);
        }).toList();
      });
    }
    Future<void> createAd() async {
      AppToasts.toastLoading();
      var token = await AppSharedPreferences.getKey(AppConstants.TOKEN);
      var headers = {
        'Accept': 'application/json',
        'Authorization': ' Bearer $token'
      };
      var data = FormData.fromMap({
        'images1': _images.length > 0 ? await MultipartFile.fromFile(
            _images[0].path,
            filename: _images[0].path) : null,
        'images2': _images.length > 1 ? await MultipartFile.fromFile(
            _images[1].path,
            filename: _images[1].path) : null,
        'images3': _images.length > 2 ? await MultipartFile.fromFile(
            _images[2].path,
            filename: _images[2].path) : null,
        'images4': _images.length > 3 ? await MultipartFile.fromFile(
            _images[3].path,
            filename: _images[3].path) : null,
        'images5': _images.length > 4 ? await MultipartFile.fromFile(
            _images[4].path,
            filename: _images[4].path) : null,
        'title': titleController.text,
        'category_id': categoryController.text,
        'price': priceController.text,
        'phone': phoneController.text,
        'whatsapp': whatsappController.text,
        'des': descriptionController.text
      });

      var dio = Dio();
      try {
        var response = await dio.request(
          'https://alnsher.com/api/V1/ads',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          print(json.encode(response.data));
          AppToasts.hideLoading();
          HomeCubit
              .get(context)
              .ads
              .add(Ad.fromJson(response.data['data_response']['ads']));
          HomeCubit.get(context).getHomeResponse().then((value) {
            setState(() {
              AppToasts.hideLoading();
              AppToasts.toastSuccess(msg: 'تمت اضافة منتج بنجاح ');
            });
          });
        }
      } on DioException catch (e) {
        AppToasts.toastError(msg: e.response!.data['message'].toString());
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [

            GestureDetector(
              onTap: () => _getImages(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: _images.isEmpty
                          ? [
                        SizedBox(
                          width: double.infinity,
                          height: 190.h,
                          child: Image.asset(ImagesManger.bigImagePiker),
                        ),
                        Image.asset(ImagesManger.smallImagePiker,
                            width: 80.w),
                        Image.asset(ImagesManger.smallImagePiker,
                            width: 80.w),
                        Image.asset(ImagesManger.smallImagePiker,
                            width: 80.w),
                        Image.asset(ImagesManger.smallImagePiker,
                            width: 80.w),
                      ]
                          : List.generate(
                        _images.length,
                            (index) =>
                            Image.file(
                              _images[index],
                              width: 150.w,
                              height: 100,
                              fit: BoxFit.fitWidth,
                            ),
                      ),
                    ),
                    Text('اضغط هنا لرفع صور المنتج ', style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        color: AppColors.labelGrey
                    )),

                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  CustomField(
                      inputType: TextInputType.text,
                      label: 'اسم المنتج ',
                      controller: titleController),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomField(
                      inputType: TextInputType.number,
                      label: 'سعر المنتج',
                      controller: priceController),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 65.h,
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(12.r)

                    ),
                    child: DropdownButtonFormField(
                      items: HomeCubit
                          .get(context)
                          .categories
                          .map((e) =>
                          DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name!),
                          ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryController.text = value.toString();
                        });
                      },

                      dropdownColor: AppColors.white,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'التصنيف',
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .labelSmall
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomField(
                      inputType: TextInputType.phone,
                      label: 'رقم الواتساب ',
                      controller: whatsappController),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomField(
                      inputType: TextInputType.phone,
                      label: ' رقم الهاتف',
                      controller: phoneController),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomField(
                    inputType: TextInputType.multiline,
                    label: 'الوصف',
                    controller: descriptionController,
                    minLines: 6,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    color: AppColors.primaryColor,
                    text: 'أضف اعلان ',
                    onTap: createAd,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}