import 'package:flutter/material.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class DeckOfCards extends StatelessWidget {
  final List<PlayingCard> cards;

  DeckOfCards(this.cards);

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
              child: NonFlippableFaceUpPlayingCard(cards[0]),
            )
          ],
        ));
  }
}
