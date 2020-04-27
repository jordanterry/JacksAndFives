import 'package:kago_game/deck_glue.dart';
import 'package:kago_game/deck_models.dart';
import 'package:kago_game/playing_card_model.dart';

class JacksAndFives {
  Deck deck;
  Deck dealtDeck;
  Player player;
  DealtDeckState dealtDeckState;
  DeckState deckState;
  PlayerDeckState playerDeckState;

  void startGame() {
    dealtDeckState = DealtDeckState.NOTHING;
    deckState = DeckState.NOTHING;
    playerDeckState = PlayerDeckState.NOTHING;
    DeckOfCardsFactory cardsFactory = DeckOfCardsFactory();
    deck = cardsFactory.createDeck();
    dealtDeck = Deck([]);
    player = Player(
        [deck.takeTop(), deck.takeTop(), deck.takeTop(), deck.takeTop()]);
    deckState = DeckState.DRAGGABLE;
    dealtDeckState = DealtDeckState.DROPPABLE;
    playerDeckState = PlayerDeckState.DROPPABLE;
  }

  void playerReplacesTheirOwnCard(PlayingCard newCard, PlayingCard oldCard) {
    deck.removeFromDeck(newCard);
    dealtDeck.removeFromDeck(newCard);
    player.replaceCard(newCard, oldCard);
    dealtDeck.addToTop(oldCard);
    playerDeckState = PlayerDeckState.DROPPABLE;
    if (dealtDeck.size() > 0) {
      dealtDeckState = DealtDeckState.DROPPABLE_AND_DRAGGABLE;
    }
    deckState = DeckState.DRAGGABLE;
  }

  void playerMovesCardToDealtDeck(PlayingCard card) {
    deck.removeFromDeck(card);
    dealtDeck.addToTop(card);
    playerDeckState = PlayerDeckState.DROPPABLE;
    if (dealtDeck.size() > 0) {
      dealtDeckState = DealtDeckState.DROPPABLE_AND_DRAGGABLE;
    }
    deckState = DeckState.DRAGGABLE;
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
