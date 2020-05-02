import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kago_game/jaf_widgets.dart';

class SinglePlayerGameRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Player'),
      ),
      body: JackAndFivesScreen(),
    );
  }
}
