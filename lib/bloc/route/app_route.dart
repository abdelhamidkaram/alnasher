import 'package:alnsher/view/pay_screen.dart';
import 'package:alnsher/view/profile/walit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alnsher/bloc/login_bloc/login_cubit.dart';
import 'package:alnsher/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:alnsher/bloc/route/navigator_args/send_email_args.dart';
import 'package:alnsher/bloc/route/navigator_args/single_post_navigation_args.dart';
import 'package:alnsher/view/auth/login.dart';
import 'package:alnsher/view/auth/register.dart';
import 'package:alnsher/view/auth/reset_password.dart';
import 'package:alnsher/view/auth/verify_code.dart';
import 'package:alnsher/view/auth/sender.dart';
import 'package:alnsher/view/home/home_Screen.dart';
import 'package:alnsher/view/profile/my_ads.dart';
import 'package:alnsher/view/profile/policy_screen.dart';
import 'package:alnsher/view/search/search_screen.dart';
import 'package:alnsher/view/sigle_post/single_post_screen.dart';

import '../../view/profile/about_screen.dart';
import '../../view/profile/fav_screen.dart';
import '../../view/profile/support_screen.dart';
import '../../view/welcome/welcome.dart';

class AppRouteStrings {
  static const String initial = "/";
  //Auth
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String sendEmail = "/sendEmail";

  //Home
  static const String home = "/home";
  static const String resetPassword = "/resetPassword";
  static const String verify = "/verify";
  static const String search = "/search";
  static const String singlePost = "/singlePost";
  static const String pay = "/pay";

  // Profile
  static const String fav = "/vaf";
  static const String policy = "/policy";
  static const String aboutUs = "/aboutUs";
  static const String suport = "/suport";
  static const String wallet = "/wallet";
  static const String myAds = "/myAds";
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteStrings.initial:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
//Auth
      case AppRouteStrings.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );

      case AppRouteStrings.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const RegisterScreen(),
          ),
        );

      case AppRouteStrings.sendEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const SenderEmailScreen(),
          ),
        );

      case AppRouteStrings.resetPassword:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => LoginCubit(),
              child: const ResetPasswordScreen(),
            );
          },
        );
      case AppRouteStrings.verify:
        return MaterialPageRoute(
          builder: (context) {
            var args = routeSettings.arguments as SenderEmailSenderArgs;
            return BlocProvider(
              create: (context) => LoginCubit(),
              child: VerifyCodeScreen(
                email: args.email,
              ),
            );
          },
        );

        case AppRouteStrings.pay:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => LoginCubit(),
              child: PayScreen(),
            );
          },
        );

//Home
      case AppRouteStrings.home:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );

      case AppRouteStrings.search:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );

      case AppRouteStrings.singlePost:
        return MaterialPageRoute(
          builder: (context) {
            var args = routeSettings.arguments as SinglePostNavigationArgs;
            return SinglePostScreen(ad: args.ad);
          },
        );

//Profile

        case AppRouteStrings.myAds:
        return MaterialPageRoute(
          builder: (context) {
            return const MyAds();
          },
        );

        case AppRouteStrings.wallet:
        return MaterialPageRoute(
          builder: (context) {
            return const WalletScreen();
          },
        );

        case AppRouteStrings.fav:
        return MaterialPageRoute(
          builder: (context) {
            return const MyFavScreen();
          },
        );

        case AppRouteStrings.policy:
        return MaterialPageRoute(
          builder: (context) {
            return const PolicyScreen();
          },
        );
        case AppRouteStrings.aboutUs:
        return MaterialPageRoute(
          builder: (context) {
            return const AboutUsScreen();
          },
        );

        case AppRouteStrings.suport:
        return MaterialPageRoute(
          builder: (context) {
            return const SuportScreen();
          },
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(' UNDEFINED ROUTE '),
        ),
      ),
    );
  }
}

goTo(
    {required String path,
    required BuildContext context,
    required bool replacement,
    required BaseNavigatorArgs args}) {
  if (replacement) {
    Navigator.of(context).pushReplacementNamed(path, arguments: args);
  } else {
    Navigator.of(context).pushNamed(path, arguments: args);
  }
}
