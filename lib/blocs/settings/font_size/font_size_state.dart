part of 'font_size_bloc.dart';

class FontSizeState extends Equatable {
  final double fontSize;
  FontSizeState({
    this.fontSize = 20,
  });

  factory FontSizeState.initial() {
    return FontSizeState();
  }

  @override
  List<Object?> get props => [fontSize];

  @override
  String toString() => 'FontSizeState(fontSize: $fontSize)';

  FontSizeState copyWith({
    double? fontSize,
  }) {
    return FontSizeState(
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
