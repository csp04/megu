import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/card0.dart';

class Card2 extends StatelessWidget {
  final Widget child;
  final Color colorIndicator;
  final Color cardColor;

  const Card2({
    Key key,
    this.child,
    this.colorIndicator,
    this.cardColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card0(
      cardColor: cardColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
        topRight: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              color: colorIndicator,
              width: 8,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
