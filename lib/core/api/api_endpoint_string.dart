class ApiEndPoints{
  static String baseUrl = 'https://alnsher.com/api/V1/' ;
  //Auth=====================================
  static String register  = 'register' ;
  static String login  = 'login' ;
  static String resendCode = "resendCode";
  static String verifyCode = 'verifyCode';
  static String getUser = "getuser";
  static String updatePassword = "updatePassword";
  static String sendCodeForResetPassword = "resetPassword";
  static String deleteAccount = "deleteAccount";
  static String logout = "logout";


  //Profile =====================================
  static String updateProfile = "update-profile";

  // Home =====================================
  static String  homeBanner = 'banner';
  static String  home = 'home';
  static String  getPopular = 'getPopular';
  static String  getAll = 'getAll';

  // fav =================================
  static String  fav = 'fav_ads';


}