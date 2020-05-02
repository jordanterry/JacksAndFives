import 'package:flutter/material.dart';
import 'package:kago_game/dealt_deck/deck_dealt_droppable.dart';
import 'package:kago_game/dealt_deck/deck_dealt_widgets.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void CardDraggedCallback(PlayingCard newCard);

typedef void CardDraggedFromDeck();

typedef void CardDraggedBackToDeck();

class DealtDeckDraggableAndDroppable extends StatelessWidget {
  final List<PlayingCard> cards;
  final CardDraggedCallback cardDraggedCallback;
  final Key topDealtKey;
  final CardDraggedFromDeck cardDraggedFromDeck;
  final CardDraggedBackToDeck cardDraggedBackToDeck;

  DealtDeckDraggableAndDroppable(
      this.topDealtKey,
      this.cards,
      this.cardDraggedCallback,
      this.cardDraggedFromDeck,
      this.cardDraggedBackToDeck);

  @override
  Widget build(BuildContext context) {
    List<PlayingCard> draggingCards = [];
    if (cards.length == 2) {
      draggingCards = [cards[1]];
    } else if (cards.length == 3) {
      draggingCards = [cards[1], cards[2]];
    }
    return Draggable(
      child: DealtDeckDroppable(topDealtKey, cards, cardDraggedCallback),
      feedback: NonFlippableFaceUpPlayingCard(cards[0]),
      childWhenDragging: DealtDeckOfCards(topDealtKey, draggingCards),
      data: cards[0],
      onDragStarted: () {
        cardDraggedFromDeck();
      },
      onDragCompleted: () {},
      onDraggableCanceled: (velocity, offset) {
        cardDraggedBackToDeck();
      },
    );
  }
}
