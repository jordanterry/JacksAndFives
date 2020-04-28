import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';

class PlayingCardEmptyWidget extends StatelessWidget {
  PlayingCardEmptyWidget({key: Key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          height: 100,
          width: 80,
        ));
  }
}
