import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kago_game/deck_dealt_widgets.dart';
import 'package:kago_game/playing_card_model.dart';

typedef void CardDroppedCallback(PlayingCard newCard);

class DealtDeckDroppable extends StatelessWidget {
  final List<PlayingCard> cards;
  final CardDroppedCallback cardDraggedCallback;

  DealtDeckDroppable(this.cards, this.cardDraggedCallback);

  @override
  Widget build(BuildContext context) {
    return DragTarget<PlayingCard>(
        builder: (context, candidates, rejectedData) {
      return candidates.length > 0
          ? DealtDeckOfCards(this.cards)
          : DealtDeckOfCards(this.cards);
    }, onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      cardDraggedCallback(data);
    });
  }
}
