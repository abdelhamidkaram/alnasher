import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listingapp/bloc/home_bloc/home_cubit.dart';
import 'package:listingapp/bloc/login_bloc/login_cubit.dart';
import 'package:listingapp/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:listingapp/bloc/route/navigator_args/send_email_args.dart';
import 'package:listingapp/bloc/route/navigator_args/single_post_navigation_args.dart';
import 'package:listingapp/view/auth/login.dart';
import 'package:listingapp/view/auth/register.dart';
import 'package:listingapp/view/auth/reset_password.dart';
import 'package:listingapp/view/auth/verify_code.dart';
import 'package:listingapp/view/auth/sender.dart';
import 'package:listingapp/view/home/home_Screen.dart';
import 'package:listingapp/view/search/search_screen.dart';
import 'package:listingapp/view/sigle_post/single_post_screen.dart';

import '../../view/welcome/welcome.dart';

class AppRouteStrings {
  static const String initial = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String sendEmail = "/sendEmail";
  static const String home = "/home";
  static const String resetPassword = "/resetPassword";
  static const String verify = "/verify";
  static const String search = "/search";

  static const String singlePost = "/singlePost";
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteStrings.initial:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );

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

      case AppRouteStrings.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case AppRouteStrings.search:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );

      case AppRouteStrings.singlePost:
        return MaterialPageRoute(
          builder: (context) {
            var args = routeSettings.arguments as SinglePostNavigationArgs;
            return SinglePostScreen(ad:args.ad);
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
