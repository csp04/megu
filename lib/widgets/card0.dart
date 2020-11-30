import 'package:flutter/material.dart';

class Card0 extends StatelessWidget {
  final Widget child;
  final Color cardColor;
  final Function onTap;
  final BorderRadius borderRadius;

  const Card0({
    Key key,
    this.child,
    this.cardColor = Colors.white,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey[200],
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Material(
        color: cardColor,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
