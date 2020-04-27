import 'package:flutter/material.dart';
import 'package:kago_game/deck_models.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void CardDraggedCallback(PlayingCard newCard);

class DealtDeckDroppable extends StatelessWidget {
  final Deck deck;
  final CardDraggedCallback cardDraggedCallback;

  DealtDeckDroppable(this.deck, this.cardDraggedCallback);

  @override
  Widget build(BuildContext context) {
    final List<Widget> childrenCards = [];
    List<PlayingCard> topOfDeck = deck.getTop(3);
    if (topOfDeck.length == 0) {
      childrenCards.insert(
        0,
        Positioned(
            top: 0,
            left: 0,
            width: 60,
            height: 75,
            child: DragTarget<PlayingCard>(
                builder: (context, candidates, rejectedData) {
              return candidates.length > 0
                  ? PlayingCardEmptyWidget()
                  : PlayingCardEmptyWidget();
            }, onWillAccept: (data) {
              return true;
            }, onAccept: (data) {
              cardDraggedCallback(data);
            })),
      );
    } else {
      if (topOfDeck.length > 0)
        childrenCards.insert(0, _createDroppableCard(topOfDeck[0]));
      if (topOfDeck.length > 1)
        childrenCards.insert(0, _createCard(topOfDeck[1], 1));
      if (topOfDeck.length > 2)
        childrenCards.insert(0, _createCard(topOfDeck[2], 2));
    }
    return Container(
        height: 75,
        width: 76,
        child: Stack(
          children: childrenCards,
        ));
  }

  Widget _createDroppableCard(PlayingCard playingCard) {
    return Positioned(
        top: 0,
        right: 0,
        width: 60,
        height: 75,
        child: DragTarget<PlayingCard>(
            builder: (context, candidates, rejectedData) {
          return candidates.length > 0
              ? PlayingCardEmptyWidget()
              : NonFlippableFaceUpPlayingCard(playingCard);
        }, onWillAccept: (data) {
          return true;
        }, onAccept: (data) {
          cardDraggedCallback(data);
        }));
  }

  Widget _createCard(PlayingCard playingCard, int position) {
    Widget child = NonFlippableFaceUpPlayingCard(playingCard);
    if (position == 0) {
      print("Droppable.");
      child =
          DragTarget<PlayingCard>(builder: (context, candidates, rejectedData) {
        return candidates.length > 0
            ? PlayingCardEmptyWidget()
            : NonFlippableFaceUpPlayingCard(playingCard);
      }, onWillAccept: (data) {
        return true;
      }, onAccept: (data) {
        cardDraggedCallback(data);
      });
    }
    return Positioned(
      top: 0,
      right: 8.0 * position,
      width: 60,
      height: 75,
      child: child,
    );
  }
}
