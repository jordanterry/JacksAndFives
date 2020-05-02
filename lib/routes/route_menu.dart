import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kago_game/routes/route_single_player_game.dart';

class MenuRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Single Player'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SinglePlayerGameRoute()),
            );
          },
        ),
      ),
    );
  }
}
