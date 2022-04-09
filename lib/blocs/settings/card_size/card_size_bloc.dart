import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_bloc/blocs/blocs.dart';

part 'card_size_event.dart';
part 'card_size_state.dart';

class CardSizeBloc extends Bloc<CardSizeEvent, CardSizeState> {
  late StreamSubscription fontSizeSubscription;

  final FontSizeBloc fontSizeBloc;
  final double initialFontSize;

  CardSizeBloc({
    required this.fontSizeBloc,
    required this.initialFontSize,
  }) : super(CardSizeState(fontSize: initialFontSize)) {
    fontSizeSubscription =
        fontSizeBloc.stream.listen((FontSizeState fontSizeState) {
      setCardSize();
    });
    on<SetCardSizeEvent>((event, emit) {
      emit(state.copyWith(cardSize: event.cardSize));
    });
  }

  void setCardSize() {
    double _cardSize;
    if (fontSizeBloc.state.fontSize <= FontSizeStatus.size1.fontSize) {
      _cardSize = CardSizeStatus.height1.cardSize;
    } else if (fontSizeBloc.state.fontSize <= FontSizeStatus.size2.fontSize) {
      _cardSize = CardSizeStatus.height2.cardSize;
    } else if (fontSizeBloc.state.fontSize <= FontSizeStatus.size3.fontSize) {
      _cardSize = CardSizeStatus.height3.cardSize;
    } else if (fontSizeBloc.state.fontSize <= FontSizeStatus.size4.fontSize) {
      _cardSize = CardSizeStatus.height4.cardSize;
    } else if (fontSizeBloc.state.fontSize <= FontSizeStatus.size5.fontSize) {
      _cardSize = CardSizeStatus.height5.cardSize;
    } else if (fontSizeBloc.state.fontSize <= FontSizeStatus.size6.fontSize) {
      _cardSize = CardSizeStatus.height6.cardSize;
    } else {
      _cardSize = CardSizeStatus.height1.cardSize;
    }

    add(SetCardSizeEvent(cardSize: _cardSize));
  }
}
