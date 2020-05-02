import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void CardDraggedOntoPlayerDeck(int position, Rect animateFrom);

class DraggablePlayerDeckWidget extends StatefulWidget {
  final CardDraggedOntoPlayerDeck cardDraggedOntoPlayerDeck;

  DraggablePlayerDeckWidget(this.cardDraggedOntoPlayerDeck);

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
        _createCard(context, 0),
        _createCard(context, 2),
      ]),
      Column(
          mainAxisSize: MainAxisSize.min,
          children: [_createCard(context, 1), _createCard(context, 3)])
    ]);
  }

  Widget createPadding(Widget child) {
    return Padding(padding: EdgeInsets.all(8.0), child: child);
  }

  Widget _createCard(BuildContext context, int position) {
    final containerKey = GlobalKey();
    return DragTarget<PlayingCard>(
        builder: (context, candidates, rejectedData) {
      return candidates.length > 0
          ? createPadding(PlayingCardEmptyWidget(
              key: containerKey,
            ))
          : createPadding(NonFlippableFaceDownPlayingCard(
              key: containerKey,
            ));
    }, onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      var bounds = containerKey.globalPaintBounds;
      widget.cardDraggedOntoPlayerDeck(position, bounds);
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
