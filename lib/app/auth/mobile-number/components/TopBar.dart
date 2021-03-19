import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class TopBar extends StatelessWidget {
  final ValueNotifier<bool> typingNotifier;

  TopBar({@required this.typingNotifier}) : assert(typingNotifier != null);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: this.typingNotifier,
      builder: (context, value, child) {
        if (value == true) {
          return AppBar(
              leading: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: InkWell(
                    child: Icon(Icons.arrow_back, color: midGrey, size: 27.0),
                    onTap: () {
                      this.typingNotifier.value = false;
                    },
                  )));
        } else {
          return Container();
        }
      });
}
