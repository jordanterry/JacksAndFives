import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kago_game/dealt_deck/dealt_deck_dragggable_and_droppable.dart';
import 'package:kago_game/dealt_deck/deck_dealt_widgets.dart';
import 'package:kago_game/jaf_models.dart';
import 'package:kago_game/player_deck/player_deck.dart';
import 'package:kago_game/player_deck/player_deck_draggable.dart';
import 'package:kago_game/playing_card_model.dart';

import 'dealt_deck/deck_dealt_droppable.dart';
import 'deck/deck_widgets.dart';

class JackAndFivesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JackAndFivesState();
  }
}

class _JackAndFivesState extends State<JackAndFivesScreen> {
  JacksAndFives _jacksAndFives;

  GlobalKey dealtDeckKey = GlobalKey(debugLabel: "topOfDealtDeck");

  _JackAndFivesState() {
    _jacksAndFives = JacksAndFives()..startGame();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    stackChildren.add(Align(
        alignment: FractionalOffset.center,
        child: Container(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _createDealtDeckWidget(),
                ]),
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _createDeckWidget(),
                ]),
          ],
        ))));
    stackChildren.add(Align(
        alignment: FractionalOffset.bottomCenter,
        child: createPlayerDeckWidget()));

    return Scaffold(
      body: Container(
          margin: MediaQuery.of(context).padding,
          child: Stack(
              children:
                  stackChildren)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _handleCardTakenFromDealtDeck() {
    _jacksAndFives.playerTakesCardFromDealtDeck();
  }

  void _handleCardPlacedOnPlayer(int position, Rect animateFrom) {
    setState(() {
      _jacksAndFives.playerPutsCardOnCardInDeck(position);
    });
  }

  void _handleDraggedOntoDealtDeck(PlayingCard playingCard) {
    setState(() {
      _jacksAndFives.playerPutsCardOnDealtDeck();
    });
  }

  Widget createPlayerDeckWidget() {
    switch (_jacksAndFives.playerDeckState) {
      case PlayerDeckState.DROPPABLE:
        return DraggablePlayerDeckWidget(_handleCardPlacedOnPlayer);
      default: // Nothing
        return PlayerDeckWidget();
    }
  }

  Widget _createDealtDeckWidget() {
    Widget dealtDeck;
    switch (_jacksAndFives.dealtDeckState) {
      case DealtDeckState.DROPPABLE:
        dealtDeck = DealtDeckDroppable(
            dealtDeckKey,
            _jacksAndFives.jafGame.dealtDeck.getTop(3),
            _handleDraggedOntoDealtDeck);
        break;
      case DealtDeckState.DROPPABLE_AND_DRAGGABLE:
        dealtDeck = DealtDeckDraggableAndDroppable(
            dealtDeckKey,
            _jacksAndFives.jafGame.dealtDeck.getTop(3),
            _handleDraggedOntoDealtDeck, () {
          setState(() {
            _jacksAndFives.playerTakesCardFromDealtDeck();
          });
        }, () {
          setState(() {
            _jacksAndFives.playerReturnsTakenCardToDeckTakenFrom();
          });
        });
        break;
      default:
        dealtDeck = DealtDeckOfCards(
            dealtDeckKey, _jacksAndFives.jafGame.dealtDeck.getTop(3));
    }

    return dealtDeck;
  }

  Widget _createDeckWidget() {
    Widget deck;
    switch (_jacksAndFives.deckState) {
      case DeckState.DRAGGABLE:
        deck = DraggableDeckOfCards(_jacksAndFives.jafGame.deck, () {
          setState(() {
            _jacksAndFives.playerTakesCardFromDeck();
          });
        }, () {
          setState(() {
            _jacksAndFives.playerReturnsTakenCardToDeckTakenFrom();
          });
        });
        break;
      default:
        deck = DeckOfCards(_jacksAndFives.jafGame.deck);
    }
    return Container(
        width: 100, height: 100, margin: EdgeInsets.only(left: 8), child: deck);
  }
}
