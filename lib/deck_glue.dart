import 'package:kago_game/deck_models.dart';
import 'package:kago_game/playing_card_model.dart';

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
