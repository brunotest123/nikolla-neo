import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final double right;
  final double left;
  final double top;
  final double bottom;
  final Widget child;
  final double _defaultRight = 30.0;
  final double _defaultLeft = 30.0;
  final double _defaultTop = 0.0;
  final double _defaultBottom = 0.0;

  ScreenContainer(
      {@required this.child, this.right, this.left, this.top, this.bottom})
      : assert(child != null);

  @override
  Widget build(BuildContext context) => Padding(
      child: this.child,
      padding: EdgeInsets.only(
          left: (left == null ? _defaultLeft : left),
          right: (right == null ? _defaultRight : right),
          top: (top == null ? _defaultTop : top),
          bottom: (bottom == null ? _defaultBottom : bottom)));
}
