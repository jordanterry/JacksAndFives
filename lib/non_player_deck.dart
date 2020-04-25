import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class NonPlayerDeck {
  List<PlayingCard> cards;

  NonPlayerDeck(this.cards);
}

class NonPlayerDeckWidget extends StatefulWidget {
  NonPlayerDeckWidget(this.cards);

  final List<PlayingCard> cards;

  @override
  State<StatefulWidget> createState() {
    return _NonPlayerDeckState();
  }
}

class _NonPlayerDeckState extends State<NonPlayerDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return StaticNonPlayerDeckWidget(
        widget.cards[0], widget.cards[1], widget.cards[2], widget.cards[3]);
  }
}

class StaticNonPlayerDeckWidget extends StatelessWidget {
  final PlayingCard _topLeftCard;
  final PlayingCard _topRightCard;
  final PlayingCard _bottomLeftCard;
  final PlayingCard _bottomRightCard;

  StaticNonPlayerDeckWidget(this._topLeftCard, this._topRightCard,
      this._bottomLeftCard, this._bottomRightCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                child: FlippablePlayingCard.faceDown(_topLeftCard)),
//                child: NonFlippableFaceDownPlayingCard()),
            Positioned(
                left: gap,
                top: margin,
                width: cardWidth,
                height: cardHeight,
//                child: NonFlippableFaceUpPlayingCard(_topRightCard)),
                child: NonFlippableFaceDownPlayingCard()),
            Positioned(
                left: gap * 2,
                top: margin,
                width: cardWidth,
                height: cardHeight,
//                child: NonFlippableFaceUpPlayingCard(_bottomLeftCard)),
                child: NonFlippableFaceDownPlayingCard()),
            Positioned(
                left: gap * 3,
                top: margin,
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
