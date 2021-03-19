import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/GuestProfiles.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/components/widgets/HeaderInfoWithTwoLines.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class FullNameForm extends StatelessWidget {
  final ValueNotifier<bool> _formValidNotifier = ValueNotifier(false);
  final GuestProfile initalValue;
  final Box guestProfilesBox;

  FullNameForm({@required this.initalValue, @required this.guestProfilesBox})
      : assert(initalValue != null && guestProfilesBox != null) {
    _fetchGuestProfile();
  }

  Future<GuestProfile> _fetchGuestProfile() async {
    if (guestProfilesBox.values.first == null) {
      await guestProfilesBox.deleteAt(0);
      await guestProfilesBox.add(GuestProfile());
      return GuestProfile();
    }

    GuestProfile guestProfile = guestProfilesBox.values.first;

    _checkForm(guestProfile);

    return guestProfile;
  }

  _checkForm(GuestProfile guestProfile) {
    if (Validators.validateText('First name', guestProfile.firstName,
                required: true, minText: 2, maxText: 20) ==
            null &&
        Validators.validateText('First name', guestProfile.lastName,
                required: true, minText: 2, maxText: 20) ==
            null) {
      _formValidNotifier.value = true;
    } else {
      _formValidNotifier.value = false;
    }
  }

  _fetchValue(String value, {String field}) async {
    GuestProfile guestProfile = await _fetchGuestProfile();

    Map<String, dynamic> data = guestProfile.toMap();
    data[field] = value;

    await guestProfilesBox.putAt(0, GuestProfile.fromMap(data));

    _checkForm(GuestProfile.fromMap(data));
  }

  _updateGuestProfile() async {
    if (initalValue.id == null) return;

    GuestProfile guestProfile = guestProfilesBox.values.first;

    GuestProfiles().update(guestProfile: guestProfile);
  }

  _closeForm(BuildContext context) async {
    if (initalValue.id == null) {
      await _fetchValue('', field: 'first_name');
      await _fetchValue('', field: 'last_name');
    } else {
      await _fetchValue(initalValue.firstName, field: 'first_name');
      await _fetchValue(initalValue.lastName, field: 'last_name');
    }

    Navigator.pop(context);
  }

  @Deprecated('button need to refactor (create a component)')
  Widget get _disableButton => Container(
      width: 70,
      height: 50,
      child: Center(
          child: Text("Save",
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w300,
                  fontFamily: "SFUIText",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0))),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: LinearGradient(
              colors: [lighterGrey, lightGrey],
              stops: [0, 1],
              begin: Alignment(-0.71, -0.71),
              end: Alignment(0.71, 0.71))));

  @Deprecated('button need to refactor (create a component)')
  Widget _buttonSubmit(BuildContext context) => InkWell(
      onTap: () {
        _updateGuestProfile();
        Navigator.pop(context);
      },
      child: Container(
          width: 70,
          height: 50,
          child: Center(
              child: Text("Save",
                  style: TextStyle(
                      color: lightGrey,
                      fontWeight: FontWeight.w300,
                      fontFamily: "SFUIText",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0))),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              gradient: LinearGradient(
                colors: [gradientLight, gradientDark],
                stops: [0, 1],
                begin: Alignment(-0.71, -0.71),
                end: Alignment(0.71, 0.71),
                // angle: 135,
                // scale: undefined,
              ))));

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: ValueListenableBuilder(
            valueListenable: _formValidNotifier,
            builder: (context, value, child) {
              if (value == true) return _buttonSubmit(context);

              return _disableButton;
            }),
        appBar: AppBar(
            leading: Padding(
                padding: EdgeInsets.only(left: 25),
                child: InkWell(
                  child: Icon(Icons.close, color: midGrey, size: 27.0),
                  onTap: () {
                    _closeForm(context);
                  },
                ))),
        body: Column(children: [
          ScreenContainer(
              child: HeaderInfoWithTwoLines(
                  firstLine: "My", lastLine: "first and last name")),
          ScreenContainer(
              top: 40,
              child: TextFormField(
                initialValue: initalValue.firstName,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'What is your first name',
                  labelText: 'First Name *',
                ),
                autovalidateMode: AutovalidateMode.always,
                onChanged: (String value) {
                  _fetchValue(value, field: 'first_name');
                },
                validator: (String value) {
                  return Validators.validateText('First name', value,
                      required: true, minText: 2, maxText: 20);
                },
              )),
          ScreenContainer(
              top: 40,
              child: TextFormField(
                initialValue: initalValue.lastName,
                decoration: const InputDecoration(
                  icon: Icon(Icons.family_restroom),
                  hintText: 'What is your last name',
                  labelText: 'Last Name *',
                ),
                onChanged: (String value) {
                  _fetchValue(value, field: 'last_name');
                },
                autovalidateMode: AutovalidateMode.always,
                validator: (String value) {
                  return Validators.validateText('Last name', value,
                      required: true, minText: 2, maxText: 20);
                },
              )),
        ]),
      );
}
