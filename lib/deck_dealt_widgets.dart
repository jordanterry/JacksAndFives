import 'package:flutter/material.dart';
import 'package:kago_game/deck_models.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class DealtDeckOfCards extends StatelessWidget {
  final Deck deck;

  DealtDeckOfCards(this.deck);

  @override
  Widget build(BuildContext context) {
    final List<Widget> childrenCards = [];
    List<PlayingCard> topOfDeck = deck.getTop(3);
    if (topOfDeck.length == 0) {
      childrenCards.insert(
          0,
          Positioned(
            top: 0,
            left: 16,
            width: 60,
            height: 75,
            child: PlayingCardEmptyWidget(),
          ));
    } else {
      if (topOfDeck.length > 0)
        childrenCards.insert(0, _createCard(topOfDeck[0], 0));
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

  Widget _createCard(PlayingCard playingCard, int position) {
    return Positioned(
      top: 0,
      right: 8.0 * position,
      width: 60,
      height: 75,
      child: NonFlippableFaceUpPlayingCard(playingCard),
    );
  }
}
