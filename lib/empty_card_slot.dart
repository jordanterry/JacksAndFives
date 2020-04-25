import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';

class EmptyCardSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        child: Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
      height: 75,
      width: 60,
    ));
  }
}
