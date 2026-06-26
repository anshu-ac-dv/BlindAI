import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

class LoadThemeEvent extends ThemeEvent {}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    on<LoadThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey);
      if (isDark == null) {
        emit(const ThemeState(ThemeMode.system));
      } else {
        emit(ThemeState(isDark ? ThemeMode.dark : ThemeMode.light));
      }
    });

    on<ToggleThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      
      // Determine if the current effective theme is dark
      bool isCurrentlyDark;
      if (state.themeMode == ThemeMode.system) {
        isCurrentlyDark = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
      } else {
        isCurrentlyDark = state.themeMode == ThemeMode.dark;
      }
      
      final newMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
      await prefs.setBool(_themeKey, !isCurrentlyDark);
      emit(ThemeState(newMode));
    });
  }
}
