import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kago_game/playing_card_model.dart';

class NonFlippableFaceDownPlayingCard extends StatelessWidget {
  NonFlippableFaceDownPlayingCard({key: Key}) : super(key: key);

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

class PlayingCardFront extends StatelessWidget {
  final PlayingCard card;

  PlayingCardFront(this.card);

  @override
  Widget build(BuildContext context) {
    var suit = getSuit(context);
    var textValue = playingCardToFaceValue(card);
    return Container(
      height: 100,
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border(
              top: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              left: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              right: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              bottom: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)))),
      foregroundDecoration: BoxDecoration(),
      child: Stack(children: [
        Align(
          alignment: FractionalOffset.topRight,
          child: Column(children: <Widget>[
            Text(textValue,
                style: TextStyle(
                    fontSize: 11, color: Color.fromARGB(255, 0, 0, 0))),
            suit
          ]),
        ),
        Align(
            alignment: FractionalOffset.center,
            child: Text(
              textValue,
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            )),
      ]),
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

  Widget getSuit(BuildContext context) {
    Image image;
    switch (card.cardSuit) {
      case CardSuit.CLUBS:
        image = getClub(context);
        break;
      case CardSuit.HEARTS:
        image = getHeart(context);
        break;
      case CardSuit.DIAMONDS:
        image = getDiamond(context);
        break;
      default: // Represents spades, should only be spades. Don't know dart well enough to make this explicit.
        image = getSpade(context);
        break;
    }
    return image;
  }

  Image getHeart(BuildContext context) {
    return Image.asset(
      'assets/cards_heart.png',
      width: 24,
      height: 24,
    );
  }

  Image getDiamond(BuildContext context) {
    return Image.asset(
      'assets/cards_diamond.png',
      width: 24,
      height: 24,
    );
  }

  Image getClub(BuildContext context) {
    return Image.asset(
      'assets/cards_club.png',
      width: 24,
      height: 24,
    );
  }

  Image getSpade(BuildContext context) {
    return Image.asset(
      'assets/cards_spade.png',
      width: 16,
      height: 16,
    );
  }
}

class PlayingCardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BorderSide cardBorder =
        BorderSide(width: 5, color: const Color.fromARGB(255, 0, 0, 0));
    return Container(
      height: 100,
      width: 80,
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
