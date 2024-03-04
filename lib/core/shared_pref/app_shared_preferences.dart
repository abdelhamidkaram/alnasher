import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../utils/constant.dart';


class AppSharedPreferences {
  static int id = -1;
  static String TOKEN = "";

  static Future<void> setKey(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static Future<void> saveUser(String token, UserModel user) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(AppConstants.ID, user.id!);
    await preferences.setString(AppConstants.TOKEN, token);
    TOKEN = token;
    await preferences.setString(AppConstants.USER, jsonEncode(user.toJson()));
  }

  static Future<UserModel> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    if (await isLogin()) {
      var userStr = preferences.getString(AppConstants.USER).toString();
      UserModel userModel = UserModel.fromJson(jsonDecode(userStr));
      return userModel;
    }
    return UserModel();
  }

  static Future<String> getKey(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<bool> isLogin() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString(AppConstants.TOKEN) == null) {
      return false;
    }else{
    return true;
  }
  }
}
