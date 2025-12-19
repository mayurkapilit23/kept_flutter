import 'package:equatable/equatable.dart';

import '../data/repositories/theme_repository.dart';

class ThemeState extends Equatable {
  final AppTheme theme;

  const ThemeState(this.theme);

  @override
  List<Object?> get props => [theme];
}