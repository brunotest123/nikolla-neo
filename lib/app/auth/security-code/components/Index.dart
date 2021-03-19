import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/auth/security-code/components/PinCodeTextField.dart';
import 'package:nikolla_neo/app/auth/security-code/controllers/SaltController.dart';
import 'package:nikolla_neo/models/User.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import 'CountDown.dart';
import 'Footer.dart';
import 'HeaderInfo.dart';
import 'RequestNewCode.dart';
import 'SubTitleInfo.dart';

import '../../mobile-number/components/Index.dart' as mobileNumber;
import '../../../gateway/components/Index.dart' as gateway;

class Index extends StatelessWidget {
  final User user;
  final ValueNotifier<Widget> _changeScreenNotifier =
      ValueNotifier(Container());

  Index({@required this.user}) : assert(user != null);

  _securityCodeScreen(BuildContext context) => Scaffold(
      appBar: AppBar(
          leading: Padding(
              padding: EdgeInsets.only(left: 25),
              child: InkWell(
                child: Icon(Icons.arrow_back, color: midGrey, size: 27.0),
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                    return;
                  }

                  _changeScreenNotifier.value = mobileNumber.Index();
                },
              ))),
      body: Column(
        children: [
          ScreenContainer(top: 20, child: HeaderInfo()),
          ScreenContainer(top: 20, child: SubTitleInfo(user: user)),
          ScreenContainer(top: 5, child: CountDown()),
          ScreenContainer(top: 10, child: RequestNewCode()),
          ScreenContainer(
              top: 40,
              right: 155,
              child: PinCodeTextField(onCodeChanged: (String pin) {
                if (pin.length != 6) return;

                SaltController(
                        sessionParams: {'security_token': pin},
                        onSuccessAction: () {
                          _changeScreenNotifier.value =
                              gateway.Index(refreshSession: true);
                        },
                        onFailureAction: () {})
                    .call();
              })),
          ScreenContainer(top: 40, child: Footer()),
        ],
      ));

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: _changeScreenNotifier,
      builder: (context, value, child) {
        if (value.toString() == 'Container') {
          return _securityCodeScreen(context);
        }

        return value;
      });
}
