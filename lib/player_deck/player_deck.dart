import 'package:flutter/widgets.dart';
import 'package:kago_game/playing_card_model.dart';
import 'package:kago_game/playing_cards.dart';

class PlayerDeck {
  List<PlayingCard> cards;

  PlayerDeck(this.cards);
}

class PlayerDeckWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayerDeckState();
  }
}

class _PlayerDeckState extends State<PlayerDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return StaticPlayerDeckWidget();
  }
}

class StaticPlayerDeckWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _createCard(),
        _createCard(),
      ]),
      Column(
          mainAxisSize: MainAxisSize.min,
          children: [_createCard(), _createCard()])
    ]);
  }

  Widget createPadding(Widget child) {
    return Padding(padding: EdgeInsets.all(8.0), child: child);
  }

  Widget _createCard() {
    return createPadding(NonFlippableFaceDownPlayingCard(key: GlobalKey()));
  }
}
