import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class DescriptionForm extends StatelessWidget with PlaceForm {
  final Place place;

  DescriptionForm({@required this.place}) : assert(place != null) {
    map['id'] = place.id;
    map['description'] = place.description;

    checkForm();
  }

  checkForm() {
    formValidNotifier.value = (Validators.validateText(
            'Description', map['description'],
            required: false, maxText: 1000) ==
        null);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: floatingActionButton(context),
      appBar: placeAppBar(title: "Description", context: context),
      body: Column(children: [
        ScreenContainer(
            top: 40,
            child: TextFormField(
              initialValue: (this.place.description == null
                  ? ""
                  : this.place.description),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                icon: Icon(Icons.read_more_sharp),
                hintText: 'Tell me something related to your business',
                labelText: 'Description',
              ),
              maxLength: 1000,
              maxLines: 7,
              autovalidateMode: AutovalidateMode.always,
              onChanged: (String value) {
                map['description'] = value;
                checkForm();
              },
              validator: (String value) {
                return Validators.validateText('Description', value,
                    required: false, maxText: 1000);
              },
            )),
      ]));
}
