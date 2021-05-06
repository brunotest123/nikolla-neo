import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class PhoneNumberTextField extends StatelessWidget {
  final Function onCountryChange;
  final Function onPhoneChange;
  final bool textFieldEnable;
  final TextEditingController controller;
  final String initialSelection;

  PhoneNumberTextField(
      {@required this.onCountryChange,
      @required this.onPhoneChange,
      @required this.controller,
      @required this.initialSelection,
      this.textFieldEnable})
      : assert(onCountryChange != null &&
            onPhoneChange != null &&
            controller != null);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          ScreenContainer(left: 0, child: _countryCode()),
          Expanded(child: _phoneNumberTextView(context))
        ],
      );

  Widget _countryCode() => Center(
        child: CountryCodePicker(
            textStyle: _defaultStyle,
            onChanged: (CountryCode countryCode) {
              onCountryChange(countryCode.code);
            },
            initialSelection: initialSelection),
      );

  Widget _phoneNumberTextView(BuildContext context) => TextField(
        controller: controller,
        autocorrect: false,
        autofocus: true,
        enabled: (textFieldEnable == null ? true : textFieldEnable),
        onChanged: (text) {
          onPhoneChange(text);
        },
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        style: _defaultStyle,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Mobile number",
            labelStyle: TextStyle(fontSize: 15.0)),
      );

  final TextStyle _defaultStyle = TextStyle(
      color: darkGrey,
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0);
}
