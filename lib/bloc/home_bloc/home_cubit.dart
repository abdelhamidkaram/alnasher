import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listingapp/model/home_model.dart';
import 'package:listingapp/core/api/api_endpoint_string.dart';
import 'package:listingapp/core/api/dio_helper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {


  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<HomeBanner> banners = [];
  List<HomeCategory> categories = [];
  List<Ad> ads = [];
  int currentIndex = 0 ;
  List<int> fav =[];
  var pageController = PageController(initialPage: 0);


  Future getHomeResponse() {


    emit(GetHomeLoading());
    return DioHelper.getData(endpoint: ApiEndPoints.home)
        .then((value) {
          HomeModel data = HomeModel.fromJson(value.data);
          banners = data.dataResponse!.banner!;
          categories = data.dataResponse!.category!;
          ads = data.dataResponse!.ads!;
          getAllFav().then((value)
              {

        emit(GetHomeSuccess());
      });

    }).catchError((err){
      debugPrint(err.toString());
    });


  }
  
  Future getAllFav()async {
    DioHelper.getData(endpoint: ApiEndPoints.allFav).then((value){
     List listAds  = value.data['data_response']['fav']['data'];
     List<Ad> favs = listAds.map((e) => Ad.fromJson(e)).toList();
     for (var e in favs) {
        fav.add(e.id!);
     }


    }).catchError((e)=>debugPrint('Error when get all fav$e'));
  }

  Future<Ad?> changeFav({required int id}) async {
    emit(ChangeFavLoading());
    await DioHelper.postData(endpoint: ApiEndPoints.fav, body: {'ads_id': id})
        .then((v) {
      var ad = Ad.fromJson(v.data['data_response']['ads']);
          if(fav.any((e) => e == ad.id)){
            fav.remove(ad.id);
          }else{
            fav.add(ad.id!);
          }
      return ad;
    });
    emit(ChangeFavError());
    return null;
  }


  void changeCurrentIndexForNavBar(int value){
    emit(ChangNavBareLoading());
    currentIndex = value;
    pageController.jumpToPage(value);
    emit(ChangNavBareSuccess());
  }






}
