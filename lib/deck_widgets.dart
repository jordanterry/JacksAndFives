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
        child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 16,
          child: NonFlippableFaceDownPlayingCard(key: GlobalKey()),
        ),
        Positioned(
          top: 0,
          left: 8,
          child: NonFlippableFaceDownPlayingCard(key: GlobalKey()),
        ),
        Positioned(
          top: 0,
          left: 0,
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
    if (deck.size() == 0) return PlayingCardEmptyWidget(key: GlobalKey());
    Widget topCard = _createDraggableCard();
    final List<Widget> childrenCards = [
      Positioned(
        top: 0,
        left: 0,
        child: topCard,
      )
    ];
    if (deck.size() > 2) {
      childrenCards.insert(
          0,
          Positioned(
            top: 0,
            left: 8,
            child: NonFlippableFaceDownPlayingCard(key: GlobalKey()),
          ));
    }
    if (deck.size() > 3) {
      childrenCards.insert(
          0,
          Positioned(
            top: 0,
            left: 16,
            child: NonFlippableFaceDownPlayingCard(key: GlobalKey()),
          ));
    }
    return Stack(children: childrenCards);
  }

  Widget _createDraggableCard() {
    return Draggable(
      child: NonFlippableFaceUpPlayingCard(deck.topCard()),
      feedback: PlayingCardFront(deck.topCard()),
      childWhenDragging: Container(),
      data: deck.topCard(),
    );
  }
}
