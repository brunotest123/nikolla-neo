import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Products.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class ProductForm extends StatefulWidget {
  final Place place;
  final Product product;
  final List<String> suggestions = [];

  ProductForm({@required this.place, this.product}) : assert(place != null) {
    suggestions.addAll(place.products.map((e) => e.category).toSet().toList());
  }

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> with PlaceForm {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<AutoCompleteTextFieldState<String>> _autoCompletekey =
      new GlobalKey();

  @override
  void initState() {
    if (widget.product != null) {
      map['id'] = widget.product.id;
      map['name'] = widget.product.name;
      map['category_name'] = widget.product.category;
      _controller = TextEditingController(text: widget.product.category);
    }
    super.initState();
  }

  @override
  checkForm() {
    formValidNotifier.value = (Validators.validateText('Name', map['name'],
                required: true, minText: 5, maxText: 30) ==
            null) &&
        (Validators.validateText('Description', map['category_name'],
                required: true, minText: 3, maxText: 30) ==
            null);
  }

  @override
  fetchValue(BuildContext context) async {
    Product _product = await Products().save(
        domain: Domain.hosts,
        place: widget.place,
        product: Product.fromMap(map));

    Place result = Place.fromMap(widget.place.toMap());

    int _index = result.products.indexWhere((element) => element == _product);

    if (_index == -1) {
      result.products.add(_product);
    } else {
      result.products[_index] = _product;
    }

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: floatingActionButton(context),
      appBar: placeAppBar(
          title: "${widget.product == null ? "New" : "Edit"} Product",
          context: context),
      body: ListView(children: [
        ScreenContainer(
            top: 40,
            child: SimpleAutoCompleteTextField(
              key: _autoCompletekey,
              controller: _controller,
              suggestions: widget.suggestions,
              decoration: const InputDecoration(
                icon: Icon(Icons.category),
                hintText: 'What is the category of your product',
                labelText: 'Category *',
              ),
              textChanged: (value) {
                map['category_name'] = value;
                checkForm();
              },
              textSubmitted: (value) {
                map['category_name'] = value;
                checkForm();
              },
              clearOnSubmit: false,
            )),
        ScreenContainer(
            top: 40,
            child: TextFormField(
              initialValue: map['name'],
              decoration: const InputDecoration(
                icon: Icon(Icons.restaurant),
                hintText: 'What is your product name',
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
        ScreenContainer(
            top: 40,
            child: TextFormField(
              inputFormatters: [
                CurrencyTextInputFormatter(locale: widget.place.locale)
              ],
              keyboardType: TextInputType.number,
              // initialValue: "EUR" + 1001.11.toString(),
              decoration: const InputDecoration(
                icon: Icon(Icons.money),
                hintText: 'What is the sales amount',
                labelText: 'Sale amount *',
              ),
              autovalidateMode: AutovalidateMode.always,
              onChanged: (String value) {
                print(value);
                // checkForm();
              },
              validator: (String value) {
                return Validators.validateText('Sale amount', value,
                    required: true, minText: 5, maxText: 30);
              },
            )),
      ]));
}
