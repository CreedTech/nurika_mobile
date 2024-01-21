import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';
import 'constants.dart';

const lightTextTheme = TextTheme(
  bodyMedium: TextStyle(color: ColorName.chineseBlack),
);

const darkTextTheme = TextTheme(
  bodyMedium: TextStyle(color: ColorName.chineseBlack),
);

final lightTheme = ThemeData(
  primarySwatch: ColorName.oceanGreenSwatch,
  scaffoldBackgroundColor: white,
  fontFamily: FontFamily.outfit,
  brightness: Brightness.light,
  textTheme: lightTextTheme,
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorName.darkJungleGreen,
  primarySwatch: ColorName.oceanGreenSwatch,
  fontFamily: FontFamily.outfit,
  brightness: Brightness.dark,
  textTheme: darkTextTheme,
);
