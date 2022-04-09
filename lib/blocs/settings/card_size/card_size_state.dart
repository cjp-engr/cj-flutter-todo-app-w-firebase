part of 'card_size_bloc.dart';

enum CardSizeStatus {
  height1,
  height2,
  height3,
  height4,
  height5,
  height6,
}

extension CardSizeExtension on CardSizeStatus {
  double get cardSize {
    switch (this) {
      case CardSizeStatus.height1:
        return 80;
      case CardSizeStatus.height2:
        return 90;
      case CardSizeStatus.height3:
        return 100;
      case CardSizeStatus.height4:
        return 105;
      case CardSizeStatus.height5:
        return 110;
      case CardSizeStatus.height6:
        return 120;
    }
  }
}

enum FontSizeStatus {
  size1,
  size2,
  size3,
  size4,
  size5,
  size6,
}

extension FontSizeExtension on FontSizeStatus {
  double get fontSize {
    switch (this) {
      case FontSizeStatus.size1:
        return 20;
      case FontSizeStatus.size2:
        return 23;
      case FontSizeStatus.size3:
        return 26;
      case FontSizeStatus.size4:
        return 29;
      case FontSizeStatus.size5:
        return 32;
      case FontSizeStatus.size6:
        return 35;
    }
  }
}

class CardSizeState extends Equatable {
  final double fontSize;
  final double cardSize;
  CardSizeState({
    this.cardSize = 80,
    required this.fontSize,
  });

  factory CardSizeState.initial() {
    return CardSizeState(fontSize: FontSizeStatus.size1.fontSize);
  }

  @override
  List<Object?> get props => [fontSize, cardSize];

  @override
  String toString() =>
      'CardSizeState(fontSize: $fontSize, cardSize: $cardSize)';

  CardSizeState copyWith({
    double? fontSize,
    double? cardSize,
  }) {
    return CardSizeState(
      fontSize: fontSize ?? this.fontSize,
      cardSize: cardSize ?? this.cardSize,
    );
  }
}
