import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/app/place/search/components/PlaceItem.dart';
import 'package:nikolla_neo/models/Place.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places;

  PlaceList({@required this.places}) : assert(places != null);

  @override
  Widget build(BuildContext context) => ListView(
      scrollDirection: Axis.vertical,
      children: this.places.map((place) => PlaceItem(place: place)).toList());
}
