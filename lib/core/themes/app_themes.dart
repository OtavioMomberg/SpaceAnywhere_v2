import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      blue1,
      blue2,
      blue3
    ]
  );

  static const whitePremium = Color.fromARGB(255, 206, 206, 207);
  static const blue1 = Color.fromARGB(255, 38, 46, 139);
  static const blue2 = Color.fromARGB(255, 12, 20, 93);
  static const blue3 = Color.fromARGB(255, 15, 6, 65);
  static const yellow = Color.fromARGB(255, 250, 221, 134);

  static const white = Colors.white;
  static const red = Colors.red;
  static const lightBlue = Colors.lightBlueAccent;

  static const borderRadius = BorderRadius.all(Radius.circular(12));

  static const systemUiOverlayStyle = SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    statusBarColor: blue1,
    statusBarIconBrightness: .light,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: blue3,
    systemNavigationBarIconBrightness: .light,
  );

  // Gambiarra enquanto não descubro a real causa do espaço entre AppBar e Container
  static const shape = BeveledRectangleBorder(
    side: BorderSide(color: blue1, width: 2),
  );

  static final appBar = AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: blue1,
    foregroundColor: whitePremium,
    systemOverlayStyle: systemUiOverlayStyle,
    shape: shape,
  );

  static final appBarWithHeightZero = AppBar(
    toolbarHeight: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: blue1,
    foregroundColor: whitePremium,
    systemOverlayStyle: systemUiOverlayStyle,
    shape: shape,
  );
}
