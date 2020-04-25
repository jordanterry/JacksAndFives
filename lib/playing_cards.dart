import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kago_game/playing_card_model.dart';

class NonFlippableFaceDownPlayingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlayingCardBack();
  }
}

class NonFlippableFaceUpPlayingCard extends StatelessWidget {
  final PlayingCard _card;

  NonFlippableFaceUpPlayingCard(this._card);

  @override
  Widget build(BuildContext context) {
    return PlayingCardFront(_card);
  }
}

class FlippablePlayingCard extends StatefulWidget {
  FlippablePlayingCard(this.card, this.isFaceDown);

  FlippablePlayingCard.faceDown(PlayingCard card) : this(card, true);

  FlippablePlayingCard.faceUp(PlayingCard card) : this(card, false);

  final PlayingCard card;

  final bool isFaceDown;

  @override
  State<StatefulWidget> createState() {
    return _FlippablePlayingCardState(isFaceDown);
  }
}

class _FlippablePlayingCardState extends State<FlippablePlayingCard>
    with SingleTickerProviderStateMixin {
  _FlippablePlayingCardState(isFaceDown) {
    if (isFaceDown) {
      _cardState = CardState.FACE_DOWN;
    } else {
      _cardState = CardState.FACE_UP;
    }
  }

  int _animationMilliseconds = 250;
  int _animationHalfMilliseconds = 125;
  CardState _cardState;
  CancelableOperation _flipCancelable;

  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _animationMilliseconds));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  void _flipToFaceUp() {
    _flipCancelable?.cancel();
    _cardState = CardState.FLIPPING_TO_FACE_UP;
    _flipCancelable = CancelableOperation.fromFuture(
        Future.delayed(Duration(milliseconds: _animationHalfMilliseconds), () {
      _cardState = CardState.FACE_UP;
    }));
    _startAnimation();
  }

  void _flipToFaceDown() {
    _flipCancelable?.cancel();
    _cardState = CardState.FLIPPING_TO_FACE_DOWN;
    _flipCancelable = CancelableOperation.fromFuture(
        Future.delayed(Duration(milliseconds: _animationHalfMilliseconds), () {
      _cardState = CardState.FACE_DOWN;
    }));
    _startAnimation();
  }

  void _startAnimation() {
    if (_animationStatus == AnimationStatus.dismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cardFace;
    if (_cardState == CardState.FACE_DOWN) {
      cardFace =
          GestureDetector(onTap: _flipToFaceUp, child: PlayingCardBack());
    } else if (_cardState == CardState.FACE_UP) {
      cardFace = GestureDetector(
          onTap: _flipToFaceDown, child: PlayingCardFront(widget.card));
    } else if (_cardState == CardState.FLIPPING_TO_FACE_DOWN) {
      cardFace = PlayingCardFront(widget.card);
    } else {
      cardFace = PlayingCardBack();
    }
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(3.14 * _animation.value),
        child: cardFace);
  }
}

class PlayingCardFront extends StatelessWidget {
  PlayingCardFront(this.card);

  final PlayingCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border(
              top: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              left: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              right: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              bottom: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)))),
      foregroundDecoration: BoxDecoration(),
      child: Center(child: Text(playingCardToFaceValue(card))),
    );
  }

  String playingCardToFaceValue(PlayingCard playingCard) {
    switch (playingCard.cardType) {
      case CardType.ONE:
        return "1";
      case CardType.TWO:
        return "2";
      case CardType.THREE:
        return "3";
      case CardType.FOUR:
        return "4";
      case CardType.FIVE:
        return "5";
      case CardType.SIX:
        return "6";
      case CardType.SEVEN:
        return "7";
      case CardType.EIGHT:
        return "8";
      case CardType.NINE:
        return "9";
      case CardType.TEN:
        return "10";
      case CardType.JACK:
        return "J";
      case CardType.QUEEN:
        return "Q";
      case CardType.KING:
        return "K";
      default:
        return "";
    }
  }
}

class PlayingCardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BorderSide cardBorder =
        BorderSide(width: 5, color: const Color.fromARGB(255, 0, 0, 0));
    return Container(
      height: 75,
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 0, 0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border(
              top: cardBorder,
              left: cardBorder,
              right: cardBorder,
              bottom: cardBorder)),
      foregroundDecoration: BoxDecoration(),
    );
  }
}

enum CardState {
  FACE_DOWN,
  FACE_UP,
  FLIPPING_TO_FACE_UP,
  FLIPPING_TO_FACE_DOWN
}
