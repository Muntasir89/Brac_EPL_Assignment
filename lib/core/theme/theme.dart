import 'package:branc_epl/styles/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static MaterialColor createPrimaryMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static final darkThemeMode = ThemeData(
    fontFamily: 'WorkSans',
    primarySwatch: MaterialColor(blueOriginal.value, {
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    }),
    bottomAppBarTheme: const BottomAppBarThemeData(color: Colors.transparent),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: blueOriginal, size: 18),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: blueOriginal,
      selectionColor: blueOriginal.withValues(alpha: 0.3),
      selectionHandleColor: blueOriginal,
    ),
  );
}
