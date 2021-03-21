import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class PlaceTile extends StatelessWidget {
  final Place place;

  PlaceTile({@required this.place}) : assert(place != null);

  final Widget _iconLocation = Padding(
    padding: EdgeInsets.only(right: 5.0),
    child: Icon(Icons.location_on, color: error, size: 16.0),
  );

  final Widget ratingIcon = Padding(
    child: Icon(Icons.star, color: yellowNik, size: 14.0),
    padding: EdgeInsets.only(right: 2.0),
  );

  final Widget placeRating = Container(
    child: Text("5.0",
        style: TextStyle(
          fontFamily: 'SFUIText',
          color: darkGrey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
        )),
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListTile(
              onTap: () {},
              subtitle: Row(children: [
                _iconLocation,
                Expanded(
                    child: Text(place.addressInfo(),
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: midGrey,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        ))),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text("1.3 km",
                    style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: midGrey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ))
              ]),
              title: Row(children: [
                Expanded(
                    child: Text(place.name,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        ))),
                Padding(padding: EdgeInsets.only(right: 5)),
                Row(
                  children: <Widget>[ratingIcon, placeRating],
                )
              ]))),
    ]);
  }
}
