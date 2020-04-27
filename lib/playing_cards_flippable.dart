import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

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
