import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc.dart';
import '../bloc/theme_state.dart';
import '../data/repositories/theme_repository.dart';

class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);
}

class AppThemeListener extends StatelessWidget {
  final Widget child;
  final ThemeModeNotifier notifier;

  const AppThemeListener({
    super.key,
    required this.child,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeBloc, ThemeState, AppTheme>(
      selector: (state) => state.theme,
      builder: (_, theme) {
        notifier.value = theme == AppTheme.dark
            ? ThemeMode.dark
            : ThemeMode.light;
        return child;
      },
    );
  }
}
