import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/text_fields.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';

class EventouryAppTheme {
  EventouryAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    textTheme: EventouryTextTheme.lightTextTheme,
    // disabledColor: TColors.grey,
    brightness: Brightness.light,
    // primaryColor: TColors.primary,
    // chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: EventouryAppBarTheme.lightAppBarTheme,
    // checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    // bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: EventouryElevatedButtonTheme.lightElevatedButtonTheme,
    // outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: EventouryTextFormFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: EventouryColors.tangerine, // Cursor color
      selectionColor: EventouryColors.tangerine, // Highlighted text
      selectionHandleColor: EventouryColors.tangerine, // Handle dots
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    textTheme: EventouryTextTheme.darkTextTheme,
    // disabledColor: TColors.grey,
    brightness: Brightness.dark,
    // primaryColor: TColors.primary,
    // chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: EventouryAppBarTheme.darkAppBarTheme,
    // checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    // bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: EventouryElevatedButtonTheme.darkElevatedButtonTheme,
    // outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: EventouryTextFormFieldTheme.darkInputDecorationTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: EventouryColors.tangerine, // Cursor color
      selectionColor: EventouryColors.tangerine, // Highlighted text
      selectionHandleColor: EventouryColors.tangerine, // Handle dots
    ),
  );
}
