import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class TitleForm extends StatelessWidget with PlaceForm {
  final Place place;

  TitleForm({@required this.place}) : assert(place != null) {
    map['id'] = place.id;
    map['name'] = place.name;

    checkForm();
  }

  checkForm() {
    formValidNotifier.value = (Validators.validateText('Name', map['name'],
            required: true, minText: 5, maxText: 30) ==
        null);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: floatingActionButton(context),
      appBar: placeAppBar(title: "Name", context: context),
      body: Column(children: [
        ScreenContainer(
            top: 40,
            child: TextFormField(
              initialValue: (this.place.name == null ? "" : this.place.name),
              decoration: const InputDecoration(
                icon: Icon(Icons.restaurant),
                hintText: 'What is your restaurant name',
                labelText: 'Name *',
              ),
              autovalidateMode: AutovalidateMode.always,
              onChanged: (String value) {
                map['name'] = value;
                checkForm();
              },
              validator: (String value) {
                return Validators.validateText('name', value,
                    required: true, minText: 5, maxText: 30);
              },
            )),
      ]));
}
