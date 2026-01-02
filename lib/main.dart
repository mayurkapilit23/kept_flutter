import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/app_root.dart';
import 'package:kept_flutter/core/utils/app_dark_theme.dart';
import 'package:kept_flutter/core/utils/app_light_theme.dart';
import 'package:kept_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:kept_flutter/features/auth/bloc/auth_event.dart';
import 'package:kept_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:kept_flutter/features/auth/data/services/auth_api_service.dart';
import 'package:kept_flutter/features/promise/bloc/promise_bloc.dart';
import 'package:kept_flutter/features/promise/data/repositories/promise_repository.dart';
import 'package:kept_flutter/features/theme/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/repositories/app_shared_preferences.dart';
import 'features/theme/data/repositories/theme_repository.dart';
import 'features/theme/utils/theme_helper.dart';

void main() async {
  debugPrint('start main');
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final themeRepository = ThemeRepository(prefs);
  final promiseRepository = PromiseRepository(prefs);
  //to load first theme
  final initialTheme = await themeRepository.getTheme();
  final appPrefs = AppSharedPreferences();
  final authRepo = AuthRepository(AuthApiService(), appPrefs);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(themeRepository, initialTheme),
        ),
        BlocProvider<PromiseBloc>(
          create: (_) => PromiseBloc(promiseRepository),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepo)..add(CheckAuth()),
        ),
      ],
      child: const MyApp(),
    ),
  );
  debugPrint('end main');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ThemeModeNotifier _themeNotifier = ThemeModeNotifier();

  @override
  Widget build(BuildContext context) {
    return AppThemeListener(
      notifier: _themeNotifier,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeNotifier,
        builder: (_, themeMode, __) {
          return MaterialApp(
            themeAnimationDuration: const Duration(milliseconds: 300),
            themeAnimationCurve: Curves.easeInOut,
            title: 'Kept',
            theme: AppLightTheme.theme,
            darkTheme: AppDarkTheme.theme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: const AppRoot(),
          );
        },
      ),
    );
  }
}
