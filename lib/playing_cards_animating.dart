import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_cards.dart';

class PlayingCardAnimating extends StatefulWidget {
  PlayingCardAnimating(this.fromTop, this.fromLeft, this.toTop, this.toLeft,
      this.onAnimationEnd);

  final double fromTop;

  final double fromLeft;

  final double toTop;

  final double toLeft;

  final OnAnimationEnd onAnimationEnd;

  @override
  State<StatefulWidget> createState() {
    return _PlayingCardAnimatingState();
  }
}

typedef void OnAnimationEnd();

class _PlayingCardAnimatingState extends State<PlayingCardAnimating>
    with SingleTickerProviderStateMixin {
  int _animationMilliseconds = 450;
  CancelableOperation _flipCancelable;

  AnimationController _animationController;
  Animation<double> _leftAnimation;
  Animation<double> _topAnimation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  double left;
  double top;

  @override
  void initState() {
    super.initState();
    left = widget.fromLeft;
    top = widget.toLeft;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _animationMilliseconds));
    _leftAnimation = Tween<double>(begin: widget.fromLeft, end: widget.toLeft)
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _topAnimation = Tween<double>(begin: widget.fromTop, end: widget.toTop)
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onAnimationEnd();
            }
          });
    _startAnimation();
  }

  void _startAnimation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _topAnimation.value,
      left: _leftAnimation.value,
      child: PlayingCardBack(),
    );
  }
}
