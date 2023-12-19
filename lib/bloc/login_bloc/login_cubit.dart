import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listingapp/bloc/login_bloc/requsets.dart';
import 'package:listingapp/core/api/api_endpoint_string.dart';
import 'package:listingapp/core/api/dio_helper.dart';
import 'package:listingapp/core/shared_pref/app_shared_preferences.dart';
import 'package:listingapp/model/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future getLogin({required LoginRequest loginRequest}) async {
   await  DioHelper.postData(
            endpoint: ApiEndPoints.login, body: loginRequest.toJson())
        .then((value) {
      AppSharedPreferences.saveUser(value.data['data_response']['token'],
          UserModel.fromJson(value.data['data_response']['user']));
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<Response<dynamic>> getRegister(
      {required RegisterRequest registerRequest}) {
    return DioHelper.postData(
        endpoint: ApiEndPoints.register, body: registerRequest.toJson());
  }

  Future<bool> verifyCode(
      {required VerifyCodeRequest verifyCodeRequest}) {
    return DioHelper.postData(
        endpoint: ApiEndPoints.verifyCode,
        body: verifyCodeRequest.toJson(),
    ).then((value){
      AppSharedPreferences.saveUser(value.data['data_response']['token'],
          UserModel.fromJson(value.data['data_response']['user']));
    return Future(() => true);
    });
  }


  Future<bool> getResetPassword(
      {required ResetPasswordRequest resetPasswordRequest}) {
    return DioHelper.postData(
        endpoint: ApiEndPoints.updatePassword,
        body: resetPasswordRequest.toJson(),
    ).then((value){
      AppSharedPreferences.clear();

    return Future(() => true);
    });
  }

  Future getSendCodForResetPassword(
      {required String email }) {
    return DioHelper.postData(
        endpoint: ApiEndPoints.sendCodeForResetPassword,
        body: {'email':email},
    );
  }
}
