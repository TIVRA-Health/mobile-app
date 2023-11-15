import 'package:flutter/material.dart';

class ColorConstants {
  static const Color cBlack = Colors.black;
  static const Color cWhite = Colors.white;
  static const Color primaryColor = cBlack;
  static const Color primaryColorDark = cBlack;
  static const Color accentColor = Colors.blue;
  static const Color cOrangeButton =Colors.red;
  static const Color cError =Color(0xffEF3F3F);
  static const Color cProfile =Color(0xffE2C3FF);
  static const Color cSideMenu =Color(0xff34135D);
  static const Color cSideMenuSelect =Color(0xff2E0D4E);
  static const Color cSideMenuSelectText =Color(0xffEA376B);
  static const Color cGrayText =Color(0xff3A3A3A);
  static const Color cTextSecond =Color(0xffD2D2D2);
  static const Color cSuccess =Color(0xff3AB549);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color cDividerColor = Colors.black12;
  static const Color cDividerMoreLightColor = Color(0xffF1F1F1);
  static const Color cDividerLightColor = Color(0xffBBBBBB);
  static const Color cEditTextBorderLightColor = Color(0xffDDDDDD);
  static const Color cHintText = Color(0xFF78909C);

  static const Color cScaffoldBackgroundColor = Color(0xffEFEFF5);
  static const Color cBorderColor= Color(0xffDFDFDF);
  static const Color cBottomNavigationBarColor = Color(0xffe5e5e5);
  static const Color cRedColor = Color(0xffFF0E0E);
  static const Color cLightRedColor = Color(0xffFFECEC);
  static const Color cGreenColor = Color(0xff23D760);
  static const Color cLightGreenColor = Color(0xffE7FFEE);
  static const Color cDashboardGradientColor = Color(0xff391061);
  static const Color cLightDashboardGradientColor = Color(0xff7A2C96);
  static const Color cLightDashboardGreenTextColor = Color(0xff15AD64);
  static const Color cLightDashboardRedTextColor = Color(0xffFE0000);
  static const Color cGrey = Color(0x60F6F8FC);
  static const Color cItemBackground = Color(0xFFF5F5F5);

  /// app Theme Color
  static const MaterialColor kPrimaryColor = MaterialColor(
    _cActionBar,
    <int, Color>{
      50: Color(0xFFFFE8F3),
      100: Color(0xFFF3B3CC),
      200: Color(0xFFE393B6),
      300: Color(0xFFC97299),
      400: Color(0xFFD9558F),
      500: Color(_cActionBar),
      600: Color(0xFFA93367),
      700: Color(0xFFA62560),
      800: Color(0xFFA21A5A),
      900: Color(0xFF690E36),
    },
  );
  static const int _cActionBar = 0xFFAA336A;

}
