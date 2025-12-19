import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/features/theme/bloc/theme_event.dart';
import 'package:kept_flutter/features/theme/bloc/theme_state.dart';

import '../data/repositories/theme_repository.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository repository;

  ThemeBloc(this.repository, AppTheme initialTheme)
    : super(ThemeState(initialTheme)) {
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await repository.saveTheme(event.theme);
    emit(ThemeState(event.theme));
  }
}
