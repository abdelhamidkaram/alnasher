import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listingapp/model/home_model.dart';
import 'package:meta/meta.dart';

import '../../core/api/api_endpoint_string.dart';
import '../../core/api/dio_helper.dart';

part 'single_state.dart';

class SingleCubit extends Cubit<SingleState> {
  SingleCubit() : super(SingleInitial());

  static SingleCubit get(context) => BlocProvider.of(context);

  Future<Ad?> changeFav({required id}) async {
    emit(ChangeFavLoading());
    await DioHelper.postData(endpoint: ApiEndPoints.fav, body: {'ads_id': id})
        .then((v){
      return Ad.fromJson(v.data['data_response']['ads']);
    });
    emit(ChangeFavError());
    return null;
  }
}
