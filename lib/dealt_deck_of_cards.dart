import 'package:flutter/material.dart';
import 'package:kago_game/empty_card_slot.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

import 'deck_of_cards.dart';

class DealtDeckOfCards extends StatelessWidget {
  final Deck deck;

  DealtDeckOfCards(this.deck);

  @override
  Widget build(BuildContext context) {
    Widget topCard = _emptyWidget();
    Widget secondCard = _emptyWidget();
    Widget thirdCard = _emptyWidget();
    List<PlayingCard> topOfDeck = deck.getTop(3);
    if (topOfDeck.length >= 1) {
      topCard = NonFlippableFaceUpPlayingCard(topOfDeck[0]);
    }
    if (topOfDeck.length >= 2) {
      secondCard = NonFlippableFaceUpPlayingCard(topOfDeck[1]);
    }
    if (topOfDeck.length >= 3) {
      thirdCard = NonFlippableFaceUpPlayingCard(topOfDeck[2]);
    }
    return Container(
        height: 75,
        width: 76,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              width: 60,
              height: 75,
              child: topCard,
              //              child: NonFlippableFaceUpPlayingCard(deck.topCard()),
            ),
            Positioned(
              top: 0,
              left: 8,
              width: 60,
              height: 75,
              child: secondCard,
            ),
            Positioned(
              top: 0,
              left: 16,
              width: 60,
              height: 75,
              child: thirdCard,
            )
          ],
        ));
  }

  Widget _emptyWidget() {
    return EmptyCardSlot();
  }
}
