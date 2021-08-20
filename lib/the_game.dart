import 'package:kago_game/deck/deck_models.dart';
import 'package:kago_game/playing_card_model.dart';

/// Glue
class PeekAtCardFromDeck {
  void invoke(TheGame theGame) {
    if (theGame.peekedCard != null) {
      throw Exception("There is already a peeked card.");
    }
    if (theGame.deck.size() < 1) {
      throw Exception("The deck must have cards to be taken.");
    }
    PlayingCard fromDeck = theGame.deck.takeTop();
    theGame.peekedCard = fromDeck;
    theGame.gameLog.add("Card moved from deck to peeked card.");
  }
}

class PeekAtCardFromDealtDeck {
  void invoke(TheGame theGame) {
    if (theGame.peekedCard != null) {
      throw Exception("There is already a peeked card.");
    }
    if (theGame.dealtDeck.size() < 1) {
      throw Exception("The dealt deck must have cards to be taken.");
    }
    PlayingCard fromDeck = theGame.dealtDeck.takeTop();
    theGame.peekedCard = fromDeck;
    theGame.gameLog.add("Card moved from dealt deck to peeked card.");
  }
}

class MovePeekedCardToPlayerHand {
  void invoke(TheGame theGame, int playerId, int positionInPlayerHand) {
    if (theGame.peekedCard != null) {
      throw Exception(
          "There must be a peeked card for it to be swapped with a player.");
    }
    GamePlayer playerToSwapWith = _getGamePlayer(playerId, theGame);
    if (playerToSwapWith == null) {
      throw Exception("The player id does not match a player in the game.");
    }
    PlayingCard peekedCard = theGame.peekedCard;
    PlayingCard oldCard = playerToSwapWith.hand
        .swapCardInPosition(positionInPlayerHand, peekedCard);
    if (oldCard == peekedCard) {
      throw Exception("The old and peeked card cannot be different.");
    }
  }

  GamePlayer _getGamePlayer(int playerId, TheGame theGame) {
    if (playerId == theGame.playerOne.playerId) {
      return theGame.playerOne;
    } else if (playerId == theGame.playerTwo.playerId) {
      return theGame.playerTwo;
    }
    return null;
  }
}

class MoveCardFromPlayerHandToDealtDeck {}

class TheGame {
  /// A deck of cards that players can place cards onto.
  Deck dealtDeck;

  /// A deck of card that players can take card from.
  Deck deck;

  /// A playing card that is being peeked at.
  /// Can be null.
  PlayingCard peekedCard;

  /// Player One
  GamePlayer playerOne;

  /// Player Two
  GamePlayer playerTwo;

  List<String> gameLog = List()..length = 500;
}

/// Models
/// go
/// here.

enum Turn { PLAYER, OTHER_PLAYER }

class GamePlayer {
  final int playerId;
  final String name;
  final HandOfCards hand;

  GamePlayer(this.playerId, this.name, this.hand);
}

class HandOfCards {
  final List<PlayingCard> cards;

  HandOfCards(this.cards);

  PlayingCard swapCardInPosition(int position, PlayingCard newCard) {
    PlayingCard oldCard = cards[position];
    cards[position] = newCard;
    return oldCard;
  }
}
