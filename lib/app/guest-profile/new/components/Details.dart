import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/EmailForm.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/FullNameForm.dart';
import 'package:nikolla_neo/app/guest-profile/new/components/GuestInfo.dart';
import 'package:nikolla_neo/app/guest-profile/new/controller/CreateGuestProfileController.dart';
import 'package:nikolla_neo/components/widgets/HeaderInfoWithTwoLines.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: _button(),
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
                },
              ))),
      body: Column(children: [
        ScreenContainer(
            top: 20,
            child: HeaderInfoWithTwoLines(
                firstLine: "We need your", lastLine: "information")),
        ScreenContainer(child: _fullName()),
        ScreenContainer(child: _email()),
      ]));

  Widget _button() {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<GuestProfile>(guestProfilesTable).listenable(),
        builder: (context, Box<GuestProfile> box, _) {
          GuestProfile guestProfile =
              (box.values.length == 0 ? GuestProfile() : box.values.first);

          if (guestProfile == null) return _disableButton;

          return (guestProfile.fullName().trim().length == 0
              ? _disableButton
              : _buttonSubmit);
        });
  }

  Widget _email() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<GuestProfile>(guestProfilesTable).listenable(),
      builder: (context, Box<GuestProfile> box, _) {
        GuestProfile _initalValue =
            (box.values.first == null ? GuestProfile() : box.values.first);

        return GuestInfo(
            fieldName: 'E-mail',
            fieldValue: (_initalValue.email == null ? '' : _initalValue.email),
            iconData: Icons.email_outlined,
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext xContext) {
                    return Container(
                        height: (MediaQuery.of(context).size.height - 40),
                        child: EmailForm(
                            guestProfilesBox: box, initalValue: _initalValue));
                  });
            });
      },
    );
  }

  Widget _fullName() => ValueListenableBuilder(
      valueListenable: Hive.box<GuestProfile>(guestProfilesTable).listenable(),
      builder: (context, Box<GuestProfile> box, child) {
        GuestProfile _initalValue =
            (box.values.first == null ? GuestProfile() : box.values.first);

        return GuestInfo(
          fieldName: 'Name',
          fieldValue: _initalValue.fullName(),
          iconData: Icons.person,
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext xContext) {
                  return Container(
                      height: (MediaQuery.of(context).size.height - 40),
                      child: FullNameForm(
                          guestProfilesBox: box, initalValue: _initalValue));
                });
          },
        );
      });

  Widget get _disableButton => Container(
      width: 50,
      height: 50,
      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: LinearGradient(
              colors: [lighterGrey, lightGrey],
              stops: [0, 1],
              begin: Alignment(-0.71, -0.71),
              end: Alignment(0.71, 0.71))));

  Widget get _buttonSubmit => InkWell(
      onTap: () {
        CreateGuestProfileController(
            onFailureAction: () {},
            onSuccessAction: (GuestProfile guestProfile) {
              print('saved');
            }).call();
      },
      child: Container(
          width: 50,
          height: 50,
          child: Icon(Icons.arrow_forward_ios, color: Colors.white),
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
}
