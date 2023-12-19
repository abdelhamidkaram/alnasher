import 'package:flutter/foundation.dart';
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

  Future getHomeResponse() {
    emit(GetHomeLoading());
    return DioHelper.getData(endpoint: ApiEndPoints.home)
        .then((value) {
          HomeModel data = HomeModel.fromJson(value.data);
          banners = data.dataResponse!.banner!;
          categories = data.dataResponse!.category!;
          ads = data.dataResponse!.ads!;
          emit(GetHomeSuccess());
    }).catchError((err){
      debugPrint(err.toString());
    });
  }


  void changeCurrentIndexForNavBar(int value){
    emit(ChangNavBareLoading());
    currentIndex = value;
    emit(ChangNavBareSuccess());
  }



}
