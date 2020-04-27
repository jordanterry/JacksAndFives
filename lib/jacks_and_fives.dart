import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kago_game/deck_of_cards_dealt.dart';
import 'package:kago_game/player_deck.dart';
import 'package:kago_game/player_deck_draggable.dart';
import 'package:kago_game/playing_card_model.dart';

import 'deck_of_cards.dart';

class JacksAndFives {
  Deck deck;
  Deck dealtDeck;
  Player player;
  TurnState turnState;

  void startGame() {
    turnState = TurnState.NOT_PLAYER_TURN;
    DeckOfCardsFactory cardsFactory = DeckOfCardsFactory();
    deck = cardsFactory.createDeck();
    dealtDeck = Deck([]);
    player = Player(
        [deck.takeTop(), deck.takeTop(), deck.takeTop(), deck.takeTop()]);
    turnState = TurnState.PLAYER_CAN_SELECT_FROM_DECK;
  }

  void userSelectedFromDeck() {
    turnState = TurnState.PLAYER_CAN_PUT_SELECTED_CARD_ON_DEALT_DECK_OR_SWAP;
  }

  void putSelectedCardOntoDealtDeck() {
    turnState = TurnState.PLAYER_CAN_SELECT_FROM_DECK;
  }

  void replacePlayerCard(PlayingCard newCard, PlayingCard oldCard) {
    deck.removeFromDeck(newCard);
    player.replaceCard(newCard, oldCard);
    dealtDeck.addToTop(oldCard);
    turnState = TurnState.PLAYER_CAN_SELECT_FROM_BOTH_DECKS;
  }
}

enum TurnState {
  PLAYER_CAN_SELECT_FROM_DECK,
  PLAYER_CAN_SELECT_FROM_BOTH_DECKS,
  PLAYER_CAN_PUT_SELECTED_CARD_ON_DEALT_DECK_OR_SWAP,
  NOT_PLAYER_TURN
}

class Player {
  List<PlayingCard> cards;

  Player(this.cards);

  void replaceCard(PlayingCard newCard, PlayingCard oldCard) {
    int index = cards.indexOf(oldCard);
    cards[index] = newCard;
  }
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
    setState(() {
      _jacksAndFives.putSelectedCardOntoDealtDeck();
    });
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

  void _handleCardDragged(PlayingCard playingCard, PlayingCard oldCard) {
    setState(() {
      _jacksAndFives.replacePlayerCard(playingCard, oldCard);
    });
  }

  Widget createPlayerDeckWidget() {
    Widget playerDeck = PlayerDeckWidget(
        _jacksAndFives.player.cards[0],
        _jacksAndFives.player.cards[1],
        _jacksAndFives.player.cards[2],
        _jacksAndFives.player.cards[3]);

    if (_jacksAndFives.turnState == TurnState.PLAYER_CAN_SELECT_FROM_DECK ||
        _jacksAndFives.turnState ==
            TurnState.PLAYER_CAN_SELECT_FROM_BOTH_DECKS) {
      return DraggablePlayerDeckWidget(
          _jacksAndFives.player.cards[0],
          _jacksAndFives.player.cards[1],
          _jacksAndFives.player.cards[2],
          _jacksAndFives.player.cards[3],
          _handleCardDragged);
    }
    return playerDeck;
  }

  Widget createDealtDeckWidget() {
    Widget dealtDeckContainer = Container(
      margin: EdgeInsets.only(right: 8),
      child: DealtDeckOfCards(_jacksAndFives.dealtDeck),
    );
    if (_jacksAndFives.turnState ==
            TurnState.PLAYER_CAN_PUT_SELECTED_CARD_ON_DEALT_DECK_OR_SWAP ||
        _jacksAndFives.turnState ==
            TurnState.PLAYER_CAN_SELECT_FROM_BOTH_DECKS) {
      return GestureDetector(
        onTap: _playerPlacesSelectedCardOnDealtDeck,
        child: dealtDeckContainer,
      );
    }
    return dealtDeckContainer;
  }

  Widget createDeckWidget() {
    Widget deck = DeckOfCards(_jacksAndFives.deck);
    if (_jacksAndFives.turnState == TurnState.PLAYER_CAN_SELECT_FROM_DECK ||
        _jacksAndFives.turnState ==
            TurnState.PLAYER_CAN_SELECT_FROM_BOTH_DECKS) {
      deck = DraggableDeckOfCards(_jacksAndFives.deck);
    }

    return Container(
        child: Container(margin: EdgeInsets.only(left: 8), child: deck));
  }
}
