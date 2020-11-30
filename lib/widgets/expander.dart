import 'dart:math';

import 'package:flutter/material.dart';

class ExpanderController {
  List<Function> _listeners = <Function>[];

  void invoke() {
    _listeners.forEach((element) {
      element();
    });
  }

  void addListener(Function listener) => _listeners.add(listener);
}

class Expander extends StatefulWidget {
  final Widget header;
  final Widget body;
  final Duration animationDuration;
  final bool isHeaderTappable;
  final ExpanderController controller;

  const Expander({
    Key key,
    this.header,
    this.body,
    this.animationDuration,
    this.isHeaderTappable = true,
    this.controller,
  }) : super(key: key);

  @override
  _ExpanderState createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander> with TickerProviderStateMixin {
  AnimationController _rotateController;
  bool _isExpanded = false;

  @override
  void initState() {
    _rotateController = AnimationController(
      duration: widget.animationDuration ??
          Duration(
            milliseconds: 150,
          ),
      vsync: this,
    );

    if (widget.controller != null) {
      widget.controller.addListener(_invoke);
    }
    super.initState();
  }

  void _invoke() {
    !_isExpanded ? _rotateController.forward() : _rotateController.reverse();
    _isExpanded = !_isExpanded;
  }

  Widget _buildExpanderButton() {
    return InkWell(
      onTap: () => _invoke(),
      child: RotationTransition(
        turns: Tween(begin: 1.0, end: 0.5)
            .chain(CurveTween(
              curve: Curves.fastOutSlowIn,
            ))
            .animate(_rotateController),
        child: Transform.rotate(
          angle: -pi / 2,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 16.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: widget.isHeaderTappable ? () => _invoke() : null,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.header,
                _buildExpanderButton(),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: Tween(
            begin: 0.0,
            end: 1.0,
          )
              .chain(CurveTween(
                curve: Curves.fastOutSlowIn,
              ))
              .animate(_rotateController),
          child: widget.body,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }
}
