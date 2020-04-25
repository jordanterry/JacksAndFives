import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kago_game/dealt_deck_of_cards.dart';
import 'package:kago_game/player_deck.dart';
import 'package:kago_game/playing_card_model.dart';

import 'deck_of_cards.dart';

class JacksAndFives {
  Deck deck;
  Deck dealtDeck;
  Player player;

  void startGame() {
    DeckOfCardsFactory cardsFactory = DeckOfCardsFactory();
    deck = cardsFactory.createDeck();
    dealtDeck = Deck([]);
    player =
        Player(deck.takeTop(), deck.takeTop(), deck.takeTop(), deck.takeTop());
  }
}

class Player {
  PlayingCard cardOne;
  PlayingCard cardTwo;
  PlayingCard cardThree;
  PlayingCard cardFour;

  Player(this.cardOne, this.cardTwo, this.cardThree, this.cardFour);
}

class JackAndFivesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JackAndFivesState();
  }
}

class _JackAndFivesState extends State<JackAndFivesScreen> {
  JacksAndFives _jacksAndFives;

  _JackAndFivesState() {
    _jacksAndFives = JacksAndFives()..startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: MediaQuery.of(context).padding,
          child: Stack(children: [
            Align(
                child: Container(
              width: 300,
              height: 90,
              alignment: FractionalOffset.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: DealtDeckOfCards(_jacksAndFives.dealtDeck),
                    ),
                    Container(
                        child: Container(
                            margin: EdgeInsets.only(left: 8),
                            child: DeckOfCards(_jacksAndFives.deck)))
                  ]),
            )),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: PlayerDeckWidget(
                    _jacksAndFives.player.cardOne,
                    _jacksAndFives.player.cardTwo,
                    _jacksAndFives.player.cardThree,
                    _jacksAndFives.player.cardFour)),
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
