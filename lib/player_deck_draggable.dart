import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

typedef void CardDraggedCallback(PlayingCard newCard, PlayingCard oldCard);

class DraggablePlayerDeckWidget extends StatefulWidget {
  final PlayingCard cardOne;
  final PlayingCard cardTwo;
  final PlayingCard cardThree;
  final PlayingCard cardFour;
  final CardDraggedCallback cardDraggedCallback;

  DraggablePlayerDeckWidget(this.cardOne, this.cardTwo, this.cardThree,
      this.cardFour, this.cardDraggedCallback);

  @override
  State<StatefulWidget> createState() {
    return _DraggablePlayerDeckWidgetState();
  }
}

class _DraggablePlayerDeckWidgetState extends State<DraggablePlayerDeckWidget> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = 75;
    double cardWidth = 60;
    double margin = 4;
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
              child: _createCard(widget.cardOne)),
          Positioned(
              right: margin,
              top: margin,
              width: cardWidth,
              height: cardHeight,
              child: _createCard(widget.cardTwo)),
          Positioned(
              left: margin,
              bottom: margin,
              width: cardWidth,
              height: cardHeight,
              child: _createCard(widget.cardThree)),
          Positioned(
              right: margin,
              bottom: margin,
              width: cardWidth,
              height: cardHeight,
              child: _createCard(widget.cardFour))
        ],
      ),
    );
  }

  Widget _createCard(PlayingCard playingCard) {
    return DragTarget<PlayingCard>(
        builder: (context, candidates, rejectedData) {
      return candidates.length > 0
          ? PlayingCardEmptyWidget() //NonFlippableFaceUpPlayingCard(candidates[0])
          : NonFlippableFaceDownPlayingCard();
    }, onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      widget.cardDraggedCallback(data, playingCard);
      setState(() {});
    });
  }
}
