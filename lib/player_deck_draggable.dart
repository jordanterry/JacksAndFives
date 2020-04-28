import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void CardDraggedCallback(
    PlayingCard newCard, PlayingCard oldCard, Rect position);

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
        _createCard(context, widget._topLeftCard),
        _createCard(context, widget._bottomLeftCard),
      ]),
      Column(mainAxisSize: MainAxisSize.min, children: [
        _createCard(context, widget._topRightCard),
        _createCard(context, widget._bottomRightCard)
      ])
    ]);
  }

  Widget _createCard(BuildContext context, PlayingCard playingCard) {
    final containerKey = GlobalKey();
    return DragTarget<PlayingCard>(
        builder: (context, candidates, rejectedData) {
      return candidates.length > 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: PlayingCardEmptyWidget(
                key: containerKey,
              ))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: NonFlippableFaceDownPlayingCard(
                key: containerKey,
              ));
    }, onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      var bounds = containerKey.globalPaintBounds;
      widget.cardDraggedCallback(data, playingCard, bounds);
      setState(() {});
    });
  }
}

extension GlobalKeyEx on GlobalKey {
  Rect get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null)?.getTranslation();
    if (translation != null && renderObject.paintBounds != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}
