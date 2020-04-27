import 'package:flutter/material.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class Deck {
  List<PlayingCard> _cards;

  Deck(this._cards);

  PlayingCard topCard() {
    return _cards[0];
  }

  PlayingCard takeTop() {
    PlayingCard top = topCard();
    _cards.remove(top);
    return top;
  }

  List<PlayingCard> getTop(int amount) {
    if (amount < _cards.length) return _cards.sublist(0, amount);
    return _cards.sublist(0);
  }

  void addToTop(PlayingCard playingCard) {
    _cards.insert(0, playingCard);
  }
}

class DeckOfCardsFactory {
  Deck createDeck() {
    return Deck(_createCards());
  }

  List<PlayingCard> _createCards() {
    List<PlayingCard> cards = [];
    for (var suit in CardSuit.values) {
      for (var face in CardType.values) {
        cards.add(PlayingCard(suit, face));
      }
    }
    return cards..shuffle();
  }
}

class DeckOfCards extends StatelessWidget {
  final Deck deck;

  DeckOfCards(this.deck);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: 76,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 16,
              width: 60,
              height: 75,
              child: NonFlippableFaceDownPlayingCard(),
            ),
            Positioned(
              top: 0,
              left: 8,
              width: 60,
              height: 75,
              child: NonFlippableFaceDownPlayingCard(),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: 60,
              height: 75,
              child: NonFlippableFaceUpPlayingCard(deck.topCard()),
            )
          ],
        ));
  }
}

class DraggableDeckOfCards extends StatelessWidget {
  final Deck deck;

  DraggableDeckOfCards(this.deck);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: 76,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 16,
              width: 60,
              height: 75,
              child: NonFlippableFaceDownPlayingCard(),
            ),
            Positioned(
              top: 0,
              left: 8,
              width: 60,
              height: 75,
              child: NonFlippableFaceDownPlayingCard(),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: 60,
              height: 75,
              child: Draggable(
                child: NonFlippableFaceUpPlayingCard(deck.topCard()),
                feedback: NonFlippableFaceUpPlayingCard(deck.topCard()),
                childWhenDragging: Container(),
                data: deck.topCard(),
              ),
            )
          ],
        ));
  }
}
