import 'package:kago_game/deck/deck_glue.dart';
import 'package:kago_game/deck/deck_models.dart';
import 'package:kago_game/jaf_models.dart';
import 'package:kago_game/playing_card_model.dart';

abstract class CardTakenByPlayer {
  final PlayingCard _playingCard;
  final Player _takenByPlayer;

  CardTakenByPlayer(this._playingCard, this._takenByPlayer);

  void placeOnADeck(Deck aDeck) {
    aDeck.addToTop(_playingCard);
  }

  void returnToDeck();

  void replaceCardOnPlayerDeck(PlayingCard cardToReplace, Deck dealtDeck) {
    _takenByPlayer.replaceCard(_playingCard, cardToReplace);
    dealtDeck.addToTop(cardToReplace);
  }
}

class CardTakenByPlayerFromDeck extends CardTakenByPlayer {
  final Deck deck;

  CardTakenByPlayerFromDeck(
      PlayingCard playingCard, Player takenByPlayer, this.deck)
      : super(playingCard, takenByPlayer);

  @override
  void returnToDeck() {
    deck.addToTop(_playingCard);
  }
}

class CardTakenByPlayerFromDealtDeck extends CardTakenByPlayer {
  final Deck dealtDeck;

  CardTakenByPlayerFromDealtDeck(
      PlayingCard playingCard, Player takenByPlayer, this.dealtDeck)
      : super(playingCard, takenByPlayer);

  @override
  void returnToDeck() {
    dealtDeck.addToTop(_playingCard);
  }
}

class JafGame {
  Deck dealtDeck;
  Deck deck;
  Player player;

  CardTakenByPlayer playerTakesCardFromDeck(Player player) {
    return CardTakenByPlayerFromDeck(deck.takeTop(), player, deck);
  }

  CardTakenByPlayer playerTakesCardFromDealtDeck(Player player) {
    return CardTakenByPlayerFromDealtDeck(
        dealtDeck.takeTop(), player, dealtDeck);
  }
}

class DeckState {
  Deck deck;
  ComponentState componentState;

  DeckState(this.deck, this.componentState);
}

class PlayerState {
  Player player;
  ComponentState componentState;

  PlayerState(this.player, this.componentState);
}

enum ComponentState { NONE, CAN_TAKE, CAN_PLACE }

class Turn {
  Player whosTurn;

  Turn(this.whosTurn);
}

class JafGameFactory {
  JafGame create() {
    var deckFactory = DeckOfCardsFactory();
    var deck = deckFactory.createDeck();
    return JafGame()
      ..deck = deck
      ..dealtDeck = Deck([])
      ..player = Player(
          [deck.takeTop(), deck.takeTop(), deck.takeTop(), deck.takeTop()]);
  }
}
