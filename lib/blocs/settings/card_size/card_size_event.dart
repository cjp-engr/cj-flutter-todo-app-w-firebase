part of 'card_size_bloc.dart';

abstract class CardSizeEvent extends Equatable {
  const CardSizeEvent();

  @override
  List<Object> get props => [];
}

class SetCardSizeEvent extends CardSizeEvent {
  final double? cardSize;
  SetCardSizeEvent({
    required this.cardSize,
  });
}
