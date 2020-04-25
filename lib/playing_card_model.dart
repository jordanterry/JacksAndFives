enum CardSuit { SPADES, HEARTS, DIAMONDS, CLUBS }

enum CardType {
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX,
  SEVEN,
  EIGHT,
  NINE,
  TEN,
  JACK,
  QUEEN,
  KING
}

class PlayingCard {
  CardSuit cardSuit;
  CardType cardType;

  PlayingCard(this.cardSuit, this.cardType);
}
