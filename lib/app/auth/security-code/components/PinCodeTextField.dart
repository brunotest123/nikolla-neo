import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PinCodeTextField extends StatelessWidget {
  final Function onCodeChanged;

  PinCodeTextField({@required this.onCodeChanged});

  @override
  Widget build(BuildContext context) => PinFieldAutoFill(
        autofocus: true,
        codeLength: 6,
        decoration: UnderlineDecoration(
            colorBuilder: FixedColorBuilder(Color(0xffd5d5d5)),
            // enteredColor: Color(0xffa5a5a5),
            lineHeight: 1.0,
            textStyle: TextStyle(
                color: Color.fromRGBO(53, 53, 53, 1), fontSize: 23.0)),
        onCodeChanged: onCodeChanged,
      );
}
