import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;
  final bool blackVersion;
  final Alignment defaultAlignment;
  final EdgeInsetsGeometry customPadding;

  Logo(
      {this.height,
      this.blackVersion,
      this.defaultAlignment,
      this.customPadding});

  @override
  Widget build(BuildContext context) {
    Widget logoArea = Align(
      alignment:
          (defaultAlignment == null ? Alignment.bottomLeft : defaultAlignment),
      child: Container(
        padding: (customPadding == null
            ? EdgeInsets.only(left: 30.0, bottom: 30.0)
            : customPadding),
        child: Image(
          image: AssetImage(blackVersion == true
              ? "lib/assets/nikolla-guest.png"
              : "lib/assets/nikolla-host.png"),
          height: this.height,
        ),
        // height: this.height,
      ),
    );

    return logoArea;
  }
}
