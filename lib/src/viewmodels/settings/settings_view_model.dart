import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants.dart';
import '../../services/interfaces/storage_service.dart';

part 'settings_view_model.freezed.dart';
part 'settings_view_model.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() {
    return SettingsState(
      themeMode: ThemeMode.values[storage.getInt(themeModeIndexKey, 1)],
      locale: Locale(storage.getString(languageCodeKey, 'en')),
    );
  }

  void update({ThemeMode? themeMode, Locale? locale}) {
    state = state.copyWith(
      themeMode: themeMode ?? state.themeMode,
      locale: locale ?? state.locale,
    );

    if (themeMode != null) {
      storage.setInt(themeModeIndexKey, themeMode.index);
    }

    if (locale != null) {
      storage.setString(languageCodeKey, locale.languageCode);
    }
  }
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required ThemeMode themeMode,
    required Locale locale,
  }) = _SettingsState;
}
