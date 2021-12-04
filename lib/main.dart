import 'package:app_shop/cubit/cubit.dart';
import 'package:app_shop/cubit/status.dart';
import 'package:app_shop/moduls/layout/shop_layout/main_shop_layout.dart';
import 'package:app_shop/shared/bloc_observe.dart';
import 'package:app_shop/shared/network/local/cash_helper.dart';
import 'package:app_shop/shared/network/remote/dio.dart';
import 'package:app_shop/shared/styles/themes.dart';
import 'package:app_shop/theme_cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'moduls/auth/login_screen.dart';
import 'moduls/onbording/onbording_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelpers.init();
  await CashHelper.init();
  bool isDark = CashHelper.getData(key: 'isDark');
  bool onBoarding = CashHelper.getData(key: 'onBoarding');
  String token = CashHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  print(onBoarding);
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,));
  // isDark!
}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

  MyApp({
    @required this.isDark,
    @required this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getDataHome()..getCategory()..getFavorite()..getUserDataModel()
        ),

        BlocProvider(
            create: (context) =>AppCubit()..changeAppMode(fromShared: isDark)
        ),
      ],

      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
             darkTheme: darkTheme,
            themeMode:
            // AppCubit.get(context).isDark?ThemeMode.dark:
            ThemeMode.light,

            home: startWidget,
          );
        },

      ),
    );



  }
// themeMode:
//     AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
// return MultiBlocProvider(
//   providers: [
//     BlocProvider(
//       create: (context) => ShopCubit(),
//     ),
//     BlocProvider(
//       create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
//     ),
//   ],
//   child: BlocConsumer<AppCubit, AppStatus>(
//     listener: (context, state) {},
//     builder: (context, state) {
//       return
// final bool isDark;
//
// MyApp(this.isDark);

// This widget is the root of your application.
}
