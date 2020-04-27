import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kago_game/dealt_deck_dragggable_and_droppable.dart';
import 'package:kago_game/deck_dealt_widgets.dart';
import 'package:kago_game/jaf_models.dart';
import 'package:kago_game/player_deck.dart';
import 'package:kago_game/player_deck_draggable.dart';
import 'package:kago_game/playing_card_model.dart';

import 'deck_dealt_droppable.dart';
import 'deck_widgets.dart';

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
                ))),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: createPlayerDeckWidget()),
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _handleCardDragged(PlayingCard playingCard, PlayingCard oldCard) {
    setState(() {
      _jacksAndFives.playerReplacesTheirOwnCard(playingCard, oldCard);
    });
  }

  void _handleDraggedOntoDealtDeck(PlayingCard playingCard) {
    setState(() {
      _jacksAndFives.playerMovesCardToDealtDeck(playingCard);
    });
  }

  Widget createPlayerDeckWidget() {
    switch (_jacksAndFives.playerDeckState) {
      case PlayerDeckState.DROPPABLE:
        return DraggablePlayerDeckWidget(
            _jacksAndFives.player.cards[0],
            _jacksAndFives.player.cards[1],
            _jacksAndFives.player.cards[2],
            _jacksAndFives.player.cards[3],
            _handleCardDragged);
      default: // Nothing
        return PlayerDeckWidget(
            _jacksAndFives.player.cards[0],
            _jacksAndFives.player.cards[1],
            _jacksAndFives.player.cards[2],
            _jacksAndFives.player.cards[3]);
    }
  }

  Widget _createDealtDeckWidget() {
    Widget dealtDeck;
    switch (_jacksAndFives.dealtDeckState) {
      case DealtDeckState.DROPPABLE:
        dealtDeck = DealtDeckDroppable(
            _jacksAndFives.dealtDeck.getTop(3), _handleDraggedOntoDealtDeck);
        break;
      case DealtDeckState.DROPPABLE_AND_DRAGGABLE:
        dealtDeck = DealtDeckDraggableAndDroppable(
            _jacksAndFives.dealtDeck.getTop(3), _handleDraggedOntoDealtDeck);
        break;
      default:
        dealtDeck = DealtDeckOfCards(_jacksAndFives.dealtDeck.getTop(3));
    }

    return dealtDeck;
  }

  Widget _createDeckWidget() {
    Widget deck;
    switch (_jacksAndFives.deckState) {
      case DeckState.DRAGGABLE:
        deck = DraggableDeckOfCards(_jacksAndFives.deck);
        break;
      default:
        deck = DeckOfCards(_jacksAndFives.deck);
    }
    return Container(
        width: 100, height: 100, margin: EdgeInsets.only(left: 8), child: deck);
  }
}
