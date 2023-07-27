import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_font.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        primary: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
        onPrimary: isDarkTheme ? Colors.white : Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.white,
        error: AppColor.primaryColor,
        onError: AppColor.primaryColor,
        background: isDarkTheme ? const Color(0xff1E293B) : AppColor.background,
        onBackground: isDarkTheme ? Colors.white : const Color(0xFFf9fcff),
        surface: AppColor.textSoft,
        onSurface: AppColor.textSoft,
      ),
      useMaterial3: false,
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xff222222) : AppColor.background,
      primarySwatch: Colors.teal,
      primaryColor: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
      indicatorColor: isDarkTheme ? Colors.white : AppColor.textStrong,
      hintColor: isDarkTheme ? AppColor.textSoft : AppColor.textSoft,
      highlightColor:
          isDarkTheme ? const Color(0xff334155) : AppColor.primaryColor,
      hoverColor: isDarkTheme ? Colors.black12 : Colors.white12,
      focusColor: isDarkTheme ? AppColor.textStrong : const Color(0xFFE6E8EE),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: AppColor.primaryColor,
        headerForegroundColor: AppColor.background,
        yearOverlayColor: MaterialStateColor.resolveWith(
            (states) => isDarkTheme ? Colors.white : AppColor.textStrong),
        dayForegroundColor: MaterialStateColor.resolveWith(
            (states) => isDarkTheme ? Colors.white : AppColor.textStrong),
        yearForegroundColor: MaterialStateColor.resolveWith(
            (states) => isDarkTheme ? Colors.white : AppColor.textStrong),
        surfaceTintColor: Colors.white,
        yearStyle: AppFont.medium12,
        weekdayStyle: AppFont.medium14.copyWith(
          color: isDarkTheme ? Colors.white : AppColor.textStrong,
        ),
        dayStyle: AppFont.medium12.copyWith(
          color: isDarkTheme ? Colors.white : AppColor.textStrong,
        ),
        backgroundColor:
            isDarkTheme ? const Color(0xff222222) : AppColor.background,
      ),
      timePickerTheme:
          const TimePickerThemeData(backgroundColor: AppColor.background),
      disabledColor: isDarkTheme ? AppColor.background : AppColor.textSoft,
      fontFamily: "Poppins",
      splashColor:
          isDarkTheme ? const Color(0xFF1F1F1F) : const Color(0xffEEF0F4),
      cardColor: isDarkTheme ? const Color(0xFF1F1F1F) : Colors.white,
      canvasColor: isDarkTheme ? const Color(0xff4E5157) : AppColor.strokeColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
          elevation: 0.5,
          backgroundColor: isDarkTheme ? AppColor.textStrong : Colors.white),
    );
  }
}
