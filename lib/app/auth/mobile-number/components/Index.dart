import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/auth/mobile-number/components/Footer.dart';
import 'package:nikolla_neo/app/auth/mobile-number/components/HeaderInfo.dart';
import 'package:nikolla_neo/app/auth/mobile-number/components/PhoneNumberTextField.dart';
import 'package:nikolla_neo/app/auth/mobile-number/components/TopBar.dart';
import 'package:nikolla_neo/app/auth/mobile-number/controllers/NewUserSessionController.dart';
import 'package:nikolla_neo/models/User.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/logo.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../security-code/components/Index.dart' as securityCode;

class Index extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _typingNotifier = ValueNotifier(false);
  final Map<String, dynamic> _loginParams = Map<String, dynamic>();

  Widget _phoneNumber() => ValueListenableBuilder(
      valueListenable: _typingNotifier,
      builder: (context, value, child) {
        return PhoneNumberTextField(
            initialSelection: _loginParams['country_id'],
            controller: _controller,
            textFieldEnable: value,
            onPhoneChange: (phoneNumber) {
              _loginParams['mobile_phone'] = phoneNumber;
            },
            onCountryChange: (countryCode) {
              _loginParams['country_id'] = countryCode.toString();
            });
      });

  Widget _screen(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TopBar(typingNotifier: _typingNotifier),
              ValueListenableBuilder(
                  valueListenable: _typingNotifier,
                  builder: (context, value, child) {
                    if (value == false) {
                      return Expanded(
                          child: Container(
                              child: Logo(height: 36),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [darkGreyFive, darkGreyThree],
                                      stops: [0, 1]))));
                    } else {
                      return Container(width: 0, height: 0);
                    }
                  }),
              Container(
                child: Column(
                  children: [
                    ScreenContainer(top: 40, child: HeaderInfo()),
                    ScreenContainer(
                        top: 40,
                        child: ValueListenableBuilder(
                            valueListenable: _typingNotifier,
                            builder: (context, value, child) {
                              if (value == true) {
                                return _phoneNumber();
                              }
                              return InkWell(
                                  child: _phoneNumber(),
                                  onTap: () {
                                    _typingNotifier.value = true;
                                  });
                            })),
                    ScreenContainer(top: 15, child: Divider()),
                    ScreenContainer(
                        top: 40,
                        bottom: 30,
                        child: Footer(
                          typingNotifier: _typingNotifier,
                          onTap: () {
                            NewUserSessionController(
                                    userParams: _loginParams,
                                    onSuccessAction: (User user) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  securityCode.Index(
                                                      user: user)));
                                    },
                                    onFailureAction: () {})
                                .call();
                          },
                        ))
                  ],
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: _typingNotifier,
                  builder: (context, value, child) {
                    if (value == true) {
                      return Expanded(child: Container(color: Colors.white));
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => _screen(context);
}
