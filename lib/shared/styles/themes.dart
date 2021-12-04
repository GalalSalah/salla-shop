import 'package:app_shop/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(

  floatingActionButtonTheme:  const FloatingActionButtonThemeData(
    backgroundColor: Colors.yellowAccent,
  ),
  textTheme: TextTheme(

      bodyText2: TextStyle(
        fontSize: 15,
        color: Colors.grey[200],
      ),

      bodyText1: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      color: HexColor('333739'),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      backwardsCompatibility: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
      actionsIconTheme: IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.lightBlue,
    unselectedItemColor: Colors.grey,
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  fontFamily:'Jannah',
);
ThemeData lightTheme = ThemeData(
  fontFamily:'Jannah',
  textTheme: TextTheme(
      bodyText2: TextStyle(
        fontSize: 11,
        color: Colors.grey[900],
      ),
      bodyText1:  TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 12)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.lightBlue,
  ),
  appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      color: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black)),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.lightBlue),
  primarySwatch: Colors.lightBlue,
  backgroundColor: Colors.white,
);
