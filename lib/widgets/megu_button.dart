import 'package:flutter/material.dart';

class MeguButton extends StatelessWidget {
  final Function onPressed;
  final Color disabledBackgroundColor;
  final Color backgroundColor;
  final Color disabledTextColor;
  final Color textColor;
  final String text;

  const MeguButton({
    Key key,
    this.onPressed,
    this.disabledBackgroundColor,
    this.backgroundColor,
    this.disabledTextColor,
    this.textColor,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      onPressed: onPressed,
      disabledColor: disabledBackgroundColor,
      color: backgroundColor,
      child: Text(
        text,
        style: TextStyle(
          color: onPressed != null ? textColor : disabledTextColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
