import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigState {
  final ThemeMode themeMode;
  final Locale locale;

  AppConfigState({
    required this.themeMode,
    required this.locale,
  });

  AppConfigState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppConfigState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}

class AppConfigCubit extends Cubit<AppConfigState> {
  final SharedPreferences _prefs;

  AppConfigCubit(this._prefs)
      : super(AppConfigState(
          themeMode: ThemeMode.values[_prefs.getInt('themeMode') ?? 2], // Default to system (2)
          locale: Locale(_prefs.getString('languageCode') ?? 'en'),
        ));

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _prefs.setInt('themeMode', newMode.index);
    emit(state.copyWith(themeMode: newMode));
  }

  void setLocale(Locale locale) {
    _prefs.setString('languageCode', locale.languageCode);
    emit(state.copyWith(locale: locale));
  }
}
