import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/card0.dart';

class Card1 extends StatelessWidget {
  final Widget child;
  final Color colorIndicator;
  final Color cardColor;
  final Function onTap;

  const Card1({
    Key key,
    this.child,
    this.colorIndicator,
    this.cardColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card0(
      onTap: onTap,
      cardColor: cardColor,
      borderRadius: BorderRadius.circular(12.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(14.0, 10.0, 4, 10.0),
              width: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: colorIndicator,
              ),
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
