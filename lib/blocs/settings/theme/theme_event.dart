part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final bool isThemeLightSwitch;
  ChangeThemeEvent({
    required this.isThemeLightSwitch,
  });

  @override
  String toString() =>
      'ChangeThemeEvent(isThemeLightSwitch: $isThemeLightSwitch)';

  @override
  List<Object> get props => [isThemeLightSwitch];
}
