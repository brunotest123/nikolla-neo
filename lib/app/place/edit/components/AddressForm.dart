import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class AddressForm extends StatelessWidget with PlaceForm {
  final Place place;

  AddressForm({@required this.place}) : assert(place != null) {
    map['id'] = place.id;
    map['country'] = (place.country == null ? '' : place.country);

    map['address_1'] = (place.addressOne == null ? '' : place.addressOne);
    map['address_2'] = (place.addressTwo == null ? '' : place.addressTwo);
    map['postal_code'] = (place.postalCode == null ? '' : place.postalCode);

    map['city'] = (place.city == null ? '' : place.city);
    map['county'] = (place.county == null ? '' : place.county);

    checkForm();
  }

  checkForm() {
    formValidNotifier.value = map['country'].trim().length > 0 &&
        map['address_1'].trim().length > 0 &&
        map['postal_code'].trim().length > 0 &&
        map['city'].trim().length > 0 &&
        map['county'].trim().length > 0;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: floatingActionButton(context),
      appBar: placeAppBar(title: "Location", context: context),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
            child: ScreenContainer(
                child: ListView(children: [
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              // icon: Icon(Icons.loca),
              hintText: '',
              labelText: 'Country',
            ),
            initialValue:
                (this.place.country == null ? "" : this.place.country),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            onChanged: (value) {
              map['country'] = value;
              checkForm();
            },
            validator: (value) {
              return null;
            },
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              // icon: Icon(Icons.loca),
              hintText: '',
              labelText: 'Address 1',
            ),
            initialValue:
                (this.place.addressOne == null ? "" : this.place.addressOne),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            onChanged: (value) {
              map['address_1'] = value;
              checkForm();
            },
            validator: (value) {
              return null;
            },
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              // icon: Icon(Icons.loca),
              hintText: '',
              labelText: 'Address 2',
            ),
            initialValue:
                (this.place.addressTwo == null ? "" : this.place.addressTwo),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            onChanged: (value) {
              map['address_2'] = value;
              checkForm();
            },
            validator: (value) {
              return null;
            },
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              // icon: Icon(Icons.loca),
              hintText: '',
              labelText: 'Postal code',
            ),
            initialValue:
                (this.place.postalCode == null ? "" : this.place.postalCode),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            onChanged: (value) {
              map['postal_code'] = value;
              checkForm();
            },
            validator: (value) {
              return null;
            },
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              // icon: Icon(Icons.loca),
              hintText: '',
              labelText: 'City',
            ),
            initialValue: (this.place.city == null ? "" : this.place.city),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            onChanged: (value) {
              map['city'] = value;
              checkForm();
            },
            validator: (value) {
              return null;
            },
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              // icon: Icon(Icons.loca),
              hintText: '',
              labelText: 'County',
            ),
            initialValue: (this.place.county == null ? "" : this.place.county),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            onChanged: (value) {
              map['county'] = value;
              checkForm();
            },
            validator: (value) {
              return null;
            },
          )
        ])))
      ]));
}
