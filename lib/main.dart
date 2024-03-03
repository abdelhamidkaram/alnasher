import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/bloc/home_bloc/home_cubit.dart';
import 'package:alnsher/bloc/route/app_route.dart';
import 'package:alnsher/core/theme.dart';
import 'bloc_observer.dart';
import 'core/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) => Center(
    child:Container(
        color: AppColors.grey,
        child: Icon(Icons.error , color: Colors.red,)),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(393, 840),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => HomeCubit()..getHomeResponse(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state)=>HomeCubit(),
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar'), // arabic
                  Locale('en'), // english
                ],
                locale: const Locale('ar'),
                title: 'alnsher App',
                theme: themeData(),
                onGenerateRoute: AppRoute.onGenerateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
