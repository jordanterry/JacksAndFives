import '../playing_card_model.dart';

class Deck {
  List<PlayingCard> _cards;

  Deck(this._cards);

  PlayingCard topCard() {
    return _cards[0];
  }

  PlayingCard takeTop() {
    PlayingCard top = topCard();
    _cards.remove(top);
    return top;
  }

  List<PlayingCard> getTop(int amount) {
    if (amount < _cards.length) return _cards.sublist(0, amount);
    return _cards.sublist(0);
  }

  void addToTop(PlayingCard playingCard) {
    _cards.insert(0, playingCard);
  }

  void removeFromDeck(PlayingCard playingCard) {
    _cards.remove(playingCard);
  }

  int size() {
    return _cards.length;
  }
}
