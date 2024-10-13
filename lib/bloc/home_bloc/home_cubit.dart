import 'package:alnsher/model/cats_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/core/shared_pref/app_shared_preferences.dart';
import 'package:alnsher/model/home_model.dart';
import 'package:alnsher/core/api/api_endpoint_string.dart';
import 'package:alnsher/core/api/dio_helper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {


  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<HomeBanner> banners = [];
  List<HomeCategory> categories = [];
  List<Ad> ads = [];
  int currentIndex = 0 ;
  List<int> fav =[];
  List<Ad> favs=[];
  List<Ad> myAds=[];
  String privacy = '';
  String about = '';


  Future getHomeResponse() {


    emit(GetHomeLoading());
    return DioHelper.getData(endpoint: ApiEndPoints.home)
        .then((value) {
          DioHelper.getData(endpoint: ApiEndPoints.cats , showLoader: false).then((value){
            categories = ResponseModel.fromJson(value.data).dataResponse;
            print('cats length : ' + categories.length.toString());
          });
            HomeModel data = HomeModel.fromJson(value.data);
            banners = data.dataResponse!.banner!;
            ads = data.dataResponse!.ads!;
          if(AppSharedPreferences.TOKEN.isNotEmpty){
            getAllFav().then((value)
            {
              emit(GetHomeSuccess());
            });
          }
    }).catchError((err){
      print(err.toString());

    });


  }

  Future getAllFav()async {
    emit(GetMyFavLoading());
    DioHelper.getData(endpoint: ApiEndPoints.allFav  ).then((value){
     List listAds  = value.data['data_response']['fav']['data'];
      favs = listAds.map((e) => Ad.fromJson(e)).toList();
     for (var e in favs) {
        fav.add(e.id!);
     }
     emit(GetMyFavFinishCall());
    }).catchError((e){
      emit(GetMyAdsError());
      debugPrint('Error when get all fav $e');});
  }

  Future<Ad?> changeFav({required int id}) async {
    emit(ChangeFavLoading());
    await DioHelper.postData(endpoint: ApiEndPoints.fav, body: {'ads_id': id})
        .then((v) async {
      var ad = Ad.fromJson(v.data['data_response']['ads']);
          if(fav.any((e) => e == ad.id)){
            fav.remove(ad.id);
            emit(ChangeFavFinishCall());
          }else{
            fav.add(ad.id!);
            emit(ChangeFavFinishCall());
          }
      return ad;
    });
    emit(ChangeFavError());
    return null;
  }


  Future getAllMyAds()async {
    emit(GetMyAdsLoading());
    DioHelper.getData(endpoint:'getMyAds').then((value){
      List listAds  = value.data['data_response']['data'];
      myAds = listAds.map((e) => Ad.fromJson(e)).toList();
      emit(GetMyAdsFinishCall());

    }).catchError((e)
    {
      emit(GetMyAdsError());

      debugPrint('Error when get all my Ads : ${e.toString()}');});
  }


  Future getPrivacy()async {
    emit(GetPrivacyLoading());
    DioHelper.getData(endpoint:'privacy').then((value){

      privacy = value.data['data_response']['privacy']['des'];
      emit(GetPrivacyFinishCall());

    }).catchError((e)
    {

      emit(GetPrivacyError());
      debugPrint('Error when get Privacy : ${e.toString()}');});

  }


  Future getAbout()async {
    emit(GetAboutLoading());
    DioHelper.getData(endpoint:'about').then((value){

      about = value.data['data_response']['about']['des'];
      emit(GetAboutFinishCall());

    }).catchError((e)
    {

      emit(GetAboutError());
      debugPrint('Error when get Privacy : ${e.toString()}');});

  }









  Future<void> changeCurrentIndexForNavBar(int value , context) async {
    bool isLogin = await AppSharedPreferences.isLogin();
     if((value == 2 || value == 4  ) && !isLogin){
       emit(ChangNavBareLoading());
       currentIndex = 0;
       goTo(path: AppRouteStrings.login, context: context, replacement: false, args: NoArgs());
       emit(ChangNavBareSuccess());
       return;
     }
    emit(ChangNavBareLoading());
    currentIndex = value;
    emit(ChangNavBareSuccess());
  }






}
