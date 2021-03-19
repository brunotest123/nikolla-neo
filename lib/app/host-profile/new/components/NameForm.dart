import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/app/host-profile/new/controllers/CreateHostAndPlaceController.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/components/widgets/HeaderInfoWithTwoLines.dart';
import 'package:nikolla_neo/models/HostProfile.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class NameForm extends StatelessWidget {
  final ValueNotifier<bool> _formValidNotifier = ValueNotifier(false);
  final HostProfile initalValue;
  final Box box;

  NameForm({@required this.box, @required this.initalValue})
      : assert(box != null && initalValue != null) {
    _fetchHostProfile();
  }

  Future<HostProfile> _fetchHostProfile() async {
    if (box.values.length == 0) {
      await box.add(HostProfile());
      return HostProfile();
    }

    HostProfile hostProfile = box.values.first;

    _checkForm(hostProfile);

    return hostProfile;
  }

  _checkForm(HostProfile hostProfile) {
    _formValidNotifier.value = (Validators.validateText(
            'Name', hostProfile.name,
            required: true, minText: 5, maxText: 30) ==
        null);
  }

  _fetchValue(String value, {String field}) async {
    HostProfile hostProfile = await _fetchHostProfile();

    Map<String, dynamic> data = hostProfile.toMap();
    data[field] = value;

    await box.putAt(0, HostProfile.fromMap(data));

    _checkForm(HostProfile.fromMap(data));
  }

  _closeForm(BuildContext context) async {
    Navigator.pop(context);
  }

  _newHostProfile() {
    CreateHostAndPlaceController(
            onSuccessAction: (HostProfile hostProfile) {},
            onFailureAction: () {})
        .call();
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
        _newHostProfile();
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
      // floatingActionButton: _button(),
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
            top: 20,
            child: HeaderInfoWithTwoLines(
                firstLine: "Tell me", lastLine: "your restaurant name")),
        ScreenContainer(
            top: 40,
            child: TextFormField(
              initialValue:
                  (this.initalValue.name == null ? "" : this.initalValue.name),
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What is your restaurant name',
                labelText: 'Name *',
              ),
              autovalidateMode: AutovalidateMode.always,
              onChanged: (String value) {
                _fetchValue(value, field: 'name');
              },
              validator: (String value) {
                return Validators.validateText('Name', value,
                    required: true, minText: 5, maxText: 30);
              },
            )),
      ]));
}
