import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kago_game/deck_of_cards_dealt.dart';
import 'package:kago_game/playing_card_empty.dart';
import 'package:kago_game/player_deck.dart';
import 'package:kago_game/player_deck_draggable.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

import 'deck_of_cards.dart';

class JacksAndFives {
  Deck deck;
  Deck dealtDeck;
  Player player;
  PlayingCard userSelectedCard;
  TurnState turnState;

  void startGame() {
    turnState = TurnState.NOT_PLAYER_TURN;
    DeckOfCardsFactory cardsFactory = DeckOfCardsFactory();
    deck = cardsFactory.createDeck();
    dealtDeck = Deck([]);
    player =
        Player(deck.takeTop(), deck.takeTop(), deck.takeTop(), deck.takeTop());
    turnState = TurnState.PLAYER_CAN_SELECT_FROM_DECK;
  }

  void userSelectedFromDeck() {
    userSelectedCard = deck.takeTop();
    turnState = TurnState.PLAYER_CAN_PUT_SELECTED_CARD_ON_DEALT_DECK_OR_SWAP;
  }

  void putSelectedCardOntoDealtDeck() {
    dealtDeck.addToTop(userSelectedCard);
    userSelectedCard = null;
    turnState = TurnState.PLAYER_CAN_SELECT_FROM_DECK;
  }
}

enum TurnState {
  PLAYER_CAN_SELECT_FROM_DECK,
  PLAYER_CAN_SELECT_FROM_BOTH_DECKS,
  PLAYER_CAN_PUT_SELECTED_CARD_ON_DEALT_DECK_OR_SWAP,
  NOT_PLAYER_TURN
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

  void _playerPlacesSelectedCardOnDealtDeck() {
    _jacksAndFives.putSelectedCardOntoDealtDeck();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: MediaQuery.of(context).padding,
          child: Stack(children: [
            Align(
                alignment: FractionalOffset.center,
                child: Container(
                  width: 300,
                  height: 180,
                  alignment: FractionalOffset.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createDealtDeckWidget(),
                        createDeckWidget(),
                      ]),
                )),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: createPlayerDeckWidget()),
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget createPlayerDeckWidget() {
    Widget playerDeck = PlayerDeckWidget(
        _jacksAndFives.player.cardOne,
        _jacksAndFives.player.cardTwo,
        _jacksAndFives.player.cardThree,
        _jacksAndFives.player.cardFour);

    if (_jacksAndFives.turnState == TurnState.PLAYER_CAN_SELECT_FROM_DECK) {
      return DraggablePlayerDeckWidget(
          _jacksAndFives.player.cardOne,
          _jacksAndFives.player.cardTwo,
          _jacksAndFives.player.cardThree,
          _jacksAndFives.player.cardFour);
    }
    return playerDeck;
  }

  Widget createDealtDeckWidget() {
    Widget dealtDeckContainer = Container(
      margin: EdgeInsets.only(right: 8),
      child: DealtDeckOfCards(_jacksAndFives.dealtDeck),
    );
    if (_jacksAndFives.turnState ==
        TurnState.PLAYER_CAN_PUT_SELECTED_CARD_ON_DEALT_DECK_OR_SWAP) {
      return GestureDetector(
        onTap: _playerPlacesSelectedCardOnDealtDeck,
        child: dealtDeckContainer,
      );
    }
    return dealtDeckContainer;
  }

  Widget createDeckWidget() {
    Widget deck = DeckOfCards(_jacksAndFives.deck);
    if (_jacksAndFives.turnState == TurnState.PLAYER_CAN_SELECT_FROM_DECK) {
      deck = DraggableDeckOfCards(_jacksAndFives.deck);
    }

    return Container(
        child: Container(margin: EdgeInsets.only(left: 8), child: deck));
  }

  Widget createSelectedCardWidget() {
    if (_jacksAndFives.userSelectedCard == null) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              key: Key("selectedCardSlot"),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: PlayingCardEmptyWidget(),
            )
          ]);
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          key: Key("selectedCardSlot"),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: NonFlippableFaceUpPlayingCard(_jacksAndFives.userSelectedCard),
        )
      ]);
    }
  }
}
