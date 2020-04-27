import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class PlayerDeck {
  List<PlayingCard> cards;

  PlayerDeck(this.cards);
}

class PlayerDeckWidget extends StatefulWidget {
  final PlayingCard cardOne;
  final PlayingCard cardTwo;
  final PlayingCard cardThree;
  final PlayingCard cardFour;

  PlayerDeckWidget(this.cardOne, this.cardTwo, this.cardThree, this.cardFour);

  @override
  State<StatefulWidget> createState() {
    return _PlayerDeckState();
  }
}

class _PlayerDeckState extends State<PlayerDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return StaticPlayerDeckWidget(
        widget.cardOne, widget.cardTwo, widget.cardThree, widget.cardFour);
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
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _createCard(_topLeftCard),
        _createCard(_bottomLeftCard),
      ]),
      Column(
          mainAxisSize: MainAxisSize.min,
          children: [_createCard(_topRightCard), _createCard(_bottomRightCard)])
    ]);
  }

  Widget _createCard(PlayingCard playingCard) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: NonFlippableFaceUpPlayingCard(playingCard));
  }
}
