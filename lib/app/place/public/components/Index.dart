import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/public/components/HeaderAppBar.dart';
import 'package:nikolla_neo/app/place/public/components/PlaceInfo.dart';
import 'package:nikolla_neo/models/Place.dart';

import '../../../bookings/new-table/components/Index.dart' as bookingNew;

class Index extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  final Place place;

  Index({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(controller: _controller, slivers: [
        HeaderAppBar(place: place, controller: _controller),
        SliverToBoxAdapter(
            child: Column(children: [
          PlaceInfo(place: place),
          bookingNew.Index(place: place)
        ]))
      ]));
}
