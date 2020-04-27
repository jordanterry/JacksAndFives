import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void CardDraggedCallback(PlayingCard newCard, PlayingCard oldCard);

class DraggablePlayerDeckWidget extends StatefulWidget {
  final PlayingCard _topLeftCard;
  final PlayingCard _topRightCard;
  final PlayingCard _bottomLeftCard;
  final PlayingCard _bottomRightCard;
  final CardDraggedCallback cardDraggedCallback;

  DraggablePlayerDeckWidget(this._topLeftCard, this._topRightCard,
      this._bottomLeftCard, this._bottomRightCard, this.cardDraggedCallback);

  @override
  State<StatefulWidget> createState() {
    return _DraggablePlayerDeckWidgetState();
  }
}

class _DraggablePlayerDeckWidgetState extends State<DraggablePlayerDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _createCard(widget._topLeftCard),
        _createCard(widget._bottomLeftCard),
      ]),
      Column(mainAxisSize: MainAxisSize.min, children: [
        _createCard(widget._topRightCard),
        _createCard(widget._bottomRightCard)
      ])
    ]);
  }

  Widget _createCard(PlayingCard playingCard) {
    return DragTarget<PlayingCard>(
        builder: (context, candidates, rejectedData) {
      return candidates.length > 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: PlayingCardEmptyWidget())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: NonFlippableFaceDownPlayingCard());
    }, onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      widget.cardDraggedCallback(data, playingCard);
      setState(() {});
    });
  }
}
