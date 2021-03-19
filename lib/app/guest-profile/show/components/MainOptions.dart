import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class MainOptions extends StatelessWidget {
  final String titleText;

  MainOptions({@required this.titleText}) : assert(titleText != null);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(this.titleText,
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ))));
  }
}
