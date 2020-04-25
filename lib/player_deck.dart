import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class PlayerDeck {
  List<PlayingCard> cards;

  PlayerDeck(this.cards);
}

class PlayerDeckWidget extends StatefulWidget {
  PlayerDeckWidget(this.cards);

  final List<PlayingCard> cards;

  @override
  State<StatefulWidget> createState() {
    return _PlayerDeckState();
  }
}

class _PlayerDeckState extends State<PlayerDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return StaticPlayerDeckWidget(
        widget.cards[0], widget.cards[1], widget.cards[2], widget.cards[3]);
  }
}

class StaticPlayerDeckWidget extends StatelessWidget {
  final PlayingCard _topLeftCard;
  final PlayingCard _topRightCard;
  final PlayingCard _bottomLeftCard;
  final PlayingCard _bottomRightCard;

  StaticPlayerDeckWidget(this._topLeftCard, this._topRightCard,
      this._bottomLeftCard, this._bottomRightCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double cardHeight = 75;
    double cardWidth = 60;
    double margin = 8;
    double playerDeckWidth = (cardWidth * 2) + margin * 4;
    double playerDeckHeight = (cardHeight * 2) + margin * 4;
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
//                child: NonFlippableFaceUpPlayingCard(_topLeftCard)),
                child: NonFlippableFaceDownPlayingCard()),
            Positioned(
                right: margin,
                top: margin,
                width: cardWidth,
                height: cardHeight,
//                child: NonFlippableFaceUpPlayingCard(_topRightCard)),
                child: NonFlippableFaceDownPlayingCard()),
            Positioned(
                left: margin,
                bottom: margin,
                width: cardWidth,
                height: cardHeight,
//                child: NonFlippableFaceUpPlayingCard(_bottomLeftCard)),
                child: NonFlippableFaceDownPlayingCard()),
            Positioned(
                right: margin,
                bottom: margin,
                width: cardWidth,
                height: cardHeight,
//                child: NonFlippableFaceUpPlayingCard(_bottomRightCard))
                child: NonFlippableFaceDownPlayingCard()),
          ],
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border(
                top: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                left: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                right: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                bottom:
                    BorderSide(color: const Color.fromARGB(255, 0, 0, 0)))));
  }
}
