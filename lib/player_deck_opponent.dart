import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_cards.dart';

class PlayerDeckOpponentWidget extends StatelessWidget {
  PlayerDeckOpponentWidget();

  @override
  Widget build(BuildContext context) {
    double cardHeight = 75;
    double cardWidth = 60;
    double margin = 8;
    double playerDeckWidth = (cardWidth * 4) + margin * 8;
    double playerDeckHeight = cardHeight + margin * 2;
    double gap = margin + cardWidth + margin;
    return Container(
      width: playerDeckWidth,
      height: playerDeckHeight,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: margin,
              top: margin,
              width: cardWidth,
              height: cardHeight,
              child: NonFlippableFaceDownPlayingCard(key: GlobalKey())),
          Positioned(
              left: gap,
              top: margin,
              width: cardWidth,
              height: cardHeight,
              child: NonFlippableFaceDownPlayingCard(key: GlobalKey())),
          Positioned(
              left: gap * 2,
              top: margin,
              width: cardWidth,
              height: cardHeight,
              child: NonFlippableFaceDownPlayingCard(key: GlobalKey())),
          Positioned(
              left: gap * 3,
              top: margin,
              width: cardWidth,
              height: cardHeight,
              child: NonFlippableFaceDownPlayingCard(key: GlobalKey())),
        ],
      ),
    );
  }
}
