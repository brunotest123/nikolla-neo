import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class HeaderInfoWithTwoLines extends StatelessWidget {
  final String firstLine;
  final String lastLine;
  final double fontSize;

  HeaderInfoWithTwoLines(
      {@required this.firstLine, @required this.lastLine, this.fontSize})
      : assert(firstLine != null && lastLine != null);

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "$firstLine\n",
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: darkGrey,
              fontSize: (fontSize == null ? 23 : fontSize),
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
        TextSpan(
            text: lastLine,
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: darkGrey,
              fontSize: (fontSize == null ? 23 : fontSize),
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
      ])));
}
