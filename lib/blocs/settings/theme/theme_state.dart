part of 'theme_bloc.dart';

enum AppThemeStatus {
  dark,
  light,
}

class ThemeState extends Equatable {
  final bool isThemeLightSwitch;
  ThemeState({
    this.isThemeLightSwitch = true,
  });

  factory ThemeState.initial() {
    return ThemeState();
  }

  @override
  List<Object?> get props => [isThemeLightSwitch];

  @override
  String toString() => 'ThemeState(isThemeLightSwitch: $isThemeLightSwitch)';

  ThemeState copyWith({
    bool? isThemeLightSwitch,
  }) {
    return ThemeState(
      isThemeLightSwitch: isThemeLightSwitch ?? this.isThemeLightSwitch,
    );
  }
}
