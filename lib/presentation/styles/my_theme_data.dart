import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyThemeData {
  // static const Color primaryColor = Color.fromARGB(255, 183, 147, 95);
  static const Color primaryColor = Colors.green;
  static const Color dprimaryColor = Color.fromARGB(255, 20, 26, 46);

  static const Color customGrey = Color(0xffF2F5F6); //green
  static const Color customRed = Color(0xffFE5D67); //green
  static const Color customPurple = Color(0xff9F4DFB); //green
  static const Color green1 = Color(0xff42C3A7); //green
  static const Color darkblue = Color(0xff3E3C6E); //ko7ly
  static const Color textColor = Color(0xff0A405B); //ko7ly

  static const Color backgroundcolor = Color(0xffffffff);
  static const Color dbackgroundcolor = Color(0xffF9FAFC);
  static const Color mywhite = Color(0xffffffff);

  ///////////////////////////////////////////////////////////
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundcolor,
    iconTheme: const IconThemeData(color: darkblue),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: mywhite, foregroundColor: darkblue),
    shadowColor: Colors.grey.withOpacity(0.3),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(3.5.w), backgroundColor: customPurple,
        // maximumSize: Size(90.w, 8.h),
        // minimumSize: Size(42.w, 6.5.h),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
          // side: BorderSide(color: Colors.red),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.white)),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: MyThemeData.primaryColor),
    primaryColor: MyThemeData.primaryColor,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 17.sp,
        color: mywhite,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
      displayMedium: TextStyle(
        fontSize: 30.sp,
        color: textColor,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
      displaySmall: TextStyle(
        fontSize: 15.sp,
        color: textColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Poppins",
      ),
      bodyLarge: TextStyle(
        fontSize: 12.sp,
        color: textColor,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
      bodyMedium: TextStyle(
        fontSize: 12.sp,
        color: textColor,
        fontFamily: "Poppins",
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        color: textColor,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: darkblue.withOpacity(0.5),
        fontFamily: "Poppins",
      ),
    ),
  );
//////////////////////////////////////////////
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: dbackgroundcolor,
    iconTheme: const IconThemeData(color: darkblue),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: Colors.black),
        // selectedItemColor: dAccentColor,
        unselectedItemColor: Colors.white,
        // selectedIconTheme: IconThemeData(color: dAccentColor),
        unselectedIconTheme: IconThemeData(color: Colors.white)),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: MyThemeData.primaryColor),
    appBarTheme: const AppBarTheme(
        centerTitle: false,
        iconTheme: IconThemeData(color: darkblue),
        titleTextStyle: TextStyle(backgroundColor: backgroundcolor),
        color: Colors.transparent,
        elevation: 0),
    primaryColor: MyThemeData.dprimaryColor,
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 22.sp, color: darkblue, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 22.sp, color: green1),
      // headline6: TextStyle(fontSize: 20.sp, color: green1),
      bodyLarge: TextStyle(
          fontSize: 14.sp, color: darkblue, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.sp, color: darkblue),
      titleMedium: TextStyle(
          fontSize: 14.sp, color: darkblue, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 12.sp, color: darkblue),
    ),
  );

  // static BuildContext get context => context;
  // TextTheme: Style(TextStyle),

}
