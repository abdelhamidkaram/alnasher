import 'package:dio/dio.dart';

import '../shared_pref/app_shared_preferences.dart';
import '../utils/constant.dart';

class DioInterceptor extends Interceptor{

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await AppSharedPreferences.getKey(AppConstants.TOKEN);
    if(token.isNotEmpty){
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Content-Type"] = "application/json";
    super.onRequest(options, handler);
  }
}