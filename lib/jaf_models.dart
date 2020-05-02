import 'package:kago_game/jaf_game.dart';
import 'package:kago_game/playing_card_model.dart';

class JacksAndFives {
  JafGame jafGame;

  DealtDeckState dealtDeckState;
  DeckState deckState;
  PlayerDeckState playerDeckState;

  CardTakenByPlayer cardTakenByPlayer;

  void startGame() {
    var jafGameFactory = JafGameFactory();
    jafGame = jafGameFactory.create();
    deckState = DeckState.DRAGGABLE;
    dealtDeckState = DealtDeckState.DROPPABLE;
    playerDeckState = PlayerDeckState.DROPPABLE;
  }

  void playerTakesCardFromDeck() {
    cardTakenByPlayer = jafGame.playerTakesCardFromDeck(jafGame.player);
    deckState = DeckState.NOTHING;
    dealtDeckState = DealtDeckState.DROPPABLE;
    playerDeckState = PlayerDeckState.DROPPABLE;
  }

  void playerTakesCardFromDealtDeck() {
    cardTakenByPlayer = jafGame.playerTakesCardFromDealtDeck(jafGame.player);
    dealtDeckState = DealtDeckState.DRAGGABLE;
    deckState = DeckState.NOTHING;
    playerDeckState = PlayerDeckState.DROPPABLE;
  }

  void playerPutsCardOnCardInDeck(int position) {
    cardTakenByPlayer?.replaceCardOnPlayerDeck(
        jafGame.player.cards[position], jafGame.dealtDeck);
    _nextGameState();
  }

  void playerPutsCardOnDealtDeck() {
    cardTakenByPlayer?.placeOnADeck(jafGame.dealtDeck);
    _nextGameState();
  }

  void playerPutsCardBackOnDeck() {
    cardTakenByPlayer?.placeOnADeck(jafGame.deck);
    _nextGameState();
  }

  void playerReturnsTakenCardToDeckTakenFrom() {
    cardTakenByPlayer?.returnToDeck();
    _nextGameState();
  }

  void _nextGameState() {
    playerDeckState = PlayerDeckState.DROPPABLE;
    if (jafGame.dealtDeck.size() > 0) {
      dealtDeckState = DealtDeckState.DROPPABLE_AND_DRAGGABLE;
    }
    if (jafGame.deck.size() > 0) {
      deckState = DeckState.DRAGGABLE;
    }
  }
}

enum DealtDeckState { NOTHING, DROPPABLE, DRAGGABLE, DROPPABLE_AND_DRAGGABLE }

enum DeckState { NOTHING, DRAGGABLE }

enum PlayerDeckState { NOTHING, DROPPABLE }

class Player {
  List<PlayingCard> cards;

  Player(this.cards);

  void replaceCard(PlayingCard newCard, PlayingCard oldCard) {
    int index = cards.indexOf(oldCard);
    cards[index] = newCard;
  }
}
