import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import 'constants.dart';

extension BuildContextPlus on BuildContext {
  bool get isInDarkMode => theme.brightness == Brightness.dark;

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  SystemUiOverlayStyle get defaultSystemUiOverlayStyle {
    return SystemUiOverlayStyle(
      systemNavigationBarColor: theme.scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: reverseBrightness,
      statusBarIconBrightness: reverseBrightness,
      statusBarColor: transparent,
    );
  }

  Brightness get reverseBrightness =>
      isInDarkMode ? Brightness.light : Brightness.dark;

  FocusScopeNode get currentFocus => FocusScope.of(this);

  ScaffoldState get scaffoldState => Scaffold.of(this);

  ColorScheme get colourScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  ThemeData get theme => Theme.of(this);

  double dy(double value) => screenHeight * value / designHeight;
  double dx(double value) => screenWidth * value / designWidth;

  void unfocus() => currentFocus.unfocus();

  TextStyle textStyle({
    Color? decorationColour,
    TextDecorationStyle? decorationStyle,
    TextDecoration? decoration,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    double? fontSize,
    double? height,
    Color? colour,
  }) {
    return textTheme.bodyMedium!.copyWith(
      fontSize: dx(fontSize ?? textTheme.bodyMedium!.fontSize!),
      decorationColor: decorationColour,
      decorationStyle: decorationStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      overflow: overflow,
      height: height,
      color: colour,
    );
  }
}

extension TimeOfDayPlus on TimeOfDay {
  String get formattedWithPeriod =>
      '${"$hourOfPeriod".padLeft(2, "0")}:${"$minute".padLeft(2, "0")} '
      '${period.name.toUpperCase()}';

  String get formatted =>
      '${"$hour".padLeft(2, "0")}:${"$minute".padLeft(2, "0")}';
}

extension DurationPlus on Duration {
  Future<bool> get delay => Future.delayed(this, () => true);
  Future<void> schedule(VoidCallback task) => Future.delayed(this, task);
}

extension DateTimePlus on DateTime {
  String get asYyMmDd => '$this'.split(' ').first;
}

extension StringPlus on String {
  bool get isValidPassword => length >= 8;

  bool get isValidReferralCode => length == 6;

  bool get isValidEmailAddress =>
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(this);

  String get capitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : this;

  String get titleCased =>
      split(RegExp(r' +')).map((part) => part.capitalized).join(' ');
}

extension NumberPlus on num {
  String get asCurrency => NumberFormat.currency(symbol: '').format(this);
  String get formatted => NumberFormat.decimalPattern().format(this);
}

extension FilePlus on File {
  String get extension => path.contains('.') ? path.split('.').last : '';
  String get name => path.contains('/') ? path.split('/').last : path;
}

extension IntPlus on int {
  String get asLongTimeString => '$seconds'.split('.').first.padLeft(8, '0');
  String get asShortTimeString => asLongTimeString.substring(3);
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
}
