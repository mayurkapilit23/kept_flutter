import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/utils/app_dark_theme.dart';
import 'package:kept_flutter/core/utils/app_light_theme.dart';
import 'package:kept_flutter/features/auth/view/mobile_input_screen.dart';
import 'package:kept_flutter/features/theme/bloc/theme_bloc.dart';
import 'package:kept_flutter/features/theme/bloc/theme_state.dart';

import 'features/promise/view/home_screen.dart';
import 'features/theme/data/repositories/theme_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeRepository = ThemeRepository();
  //to load first theme
  final initialTheme = await themeRepository.getTheme();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(themeRepository, initialTheme),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          themeAnimationDuration: const Duration(milliseconds: 300),
          themeAnimationCurve: Curves.easeInOut,
          title: 'Kept',
          theme: AppLightTheme.theme,
          darkTheme: AppDarkTheme.theme,
          themeMode: _mapThemeMode(state.theme),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          // home: MobileInputScreen(),
        );
      },
    );
  }

  ThemeMode _mapThemeMode(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
    }
  }
}
