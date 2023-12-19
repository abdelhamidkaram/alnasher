import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../toasts.dart';
import '../utils/app_string.dart';
import 'api_endpoint_string.dart';
import 'dio_interceptor.dart';

class DioHelper {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio(
        BaseOptions(
          baseUrl: ApiEndPoints.baseUrl,
          headers: {
            "Accept": "application/json",
          },
          connectTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 120),
        ),
      );
      dio!.interceptors.add(DioInterceptor());
      dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (kDebugMode) {
          print("Api-Url (${options.method}) ${options.uri}");
          print("Api-handler ${options.headers}");
          print("Api-data ${options.data}");
        }

        return handler.next(options);
      }, onResponse: (response, handler) {
        AppToasts.hideLoading();
        if (kDebugMode) {
          print("Api Response-statusCode ${response.statusCode}");
          print("Api Response-Url ${response.realUri}");
          print("Api Response-data ${response.data}");
        }
        return handler.next(response);
      }, onError: (DioException e, handler) {
        if (kDebugMode) {
          print("::: Api error : $e");
          print("Api Error Status Code: ${e.response!.statusCode}");
        }

        if (e.response!.statusCode != 500) {
          AppToasts.toastError(msg: e.response!.data["message"].toString());
        } else {
          AppToasts.toastError(msg: AppStrings.pleaseTryAgain);
        }
        return handler.next(e);
      }));
    }
    return dio!;
  }

  static Future<Response> getData(
      {required String endpoint, Map<String, dynamic>? queryParameters,bool showLoader = true}) {
    FocusManager.instance.primaryFocus?.unfocus(); //hide keyboard
    if(showLoader) {
      AppToasts.toastLoading();
    }
    return getDio().get(endpoint, queryParameters: queryParameters);
  }

  static Future<Response> postData(
      {required String endpoint,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,bool showLoader = true}) {
    if(showLoader) {
      AppToasts.toastLoading();
    }
    FocusManager.instance.primaryFocus?.unfocus(); //hide keyboard
    return getDio()
        .post(endpoint, data: body, queryParameters: queryParameters);

  }

  static Future<Response> putData(
      {required String endpoint,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,bool showLoader = true}) {
    if(showLoader) {
      AppToasts.toastLoading();
    }
    FocusManager.instance.primaryFocus?.unfocus(); //hide keyboard
    return getDio().put(endpoint, data: body, queryParameters: queryParameters);
  }
}