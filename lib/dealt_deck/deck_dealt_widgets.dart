import 'package:flutter/material.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void OnDealtDeckPosition(Rect position);

class DealtDeckOfCards extends StatelessWidget {
  final List<PlayingCard> cards;
  final Key topDealtKey;

  DealtDeckOfCards(this.topDealtKey, this.cards);

  @override
  Widget build(BuildContext context) {
    final List<Widget> childrenCards = [];
    if (cards.length == 0) {
      childrenCards.insert(
        0,
        Positioned(
            top: 0,
            right: 0.0,
            child: Container(
                key: topDealtKey,
                child: PlayingCardEmptyWidget(key: GlobalKey()))),
      );
    } else {
      if (cards.length > 0) childrenCards.insert(0, _createCard(cards[0], 0));
      if (cards.length > 1) childrenCards.insert(0, _createCard(cards[1], 1));
      if (cards.length > 2) childrenCards.insert(0, _createCard(cards[2], 2));
    }
    return Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          children: childrenCards,
        ));
  }

  Widget _createCard(PlayingCard playingCard, int position) {
    return Positioned(
      key: position == 0 ? topDealtKey : GlobalKey(),
      top: 0,
      right: 8.0 * position,
      child: NonFlippableFaceUpPlayingCard(playingCard),
    );
  }
}
