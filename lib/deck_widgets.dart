import 'package:flutter/material.dart';
import 'package:kago_game/deck_models.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_cards.dart';

class DeckOfCards extends StatelessWidget {
  final Deck deck;

  DeckOfCards(this.deck);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: 76,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 16,
              width: 60,
              height: 75,
              child: NonFlippableFaceDownPlayingCard(),
            ),
            Positioned(
              top: 0,
              left: 8,
              width: 60,
              height: 75,
              child: NonFlippableFaceDownPlayingCard(),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: 60,
              height: 75,
              child: NonFlippableFaceUpPlayingCard(deck.topCard()),
            )
          ],
        ));
  }
}

class DraggableDeckOfCards extends StatelessWidget {
  final Deck deck;

  DraggableDeckOfCards(this.deck);

  @override
  Widget build(BuildContext context) {
    return Container(height: 75, width: 76, child: _createDeckChildren());
  }

  Widget _createDeckChildren() {
    if (deck.size() == 0) return PlayingCardEmptyWidget();
    Widget topCard = _createDraggableCard();
    final List<Widget> childrenCards = [
      Positioned(
        top: 0,
        left: 0,
        width: 60,
        height: 75,
        child: topCard,
      )
    ];
    if (deck.size() > 2) {
      childrenCards.insert(
          0,
          Positioned(
            top: 0,
            left: 8,
            width: 60,
            height: 75,
            child: NonFlippableFaceDownPlayingCard(),
          ));
    }
    if (deck.size() > 3) {
      childrenCards.insert(
          0,
          Positioned(
            top: 0,
            left: 16,
            width: 60,
            height: 75,
            child: NonFlippableFaceDownPlayingCard(),
          ));
    }
    return Stack(children: childrenCards);
  }

  Widget _createDraggableCard() {
    return Draggable(
      child: NonFlippableFaceUpPlayingCard(deck.topCard()),
      feedback: NonFlippableFaceUpPlayingCard(deck.topCard()),
      childWhenDragging: Container(),
      data: deck.topCard(),
    );
  }
}
