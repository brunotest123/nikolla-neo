import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/public/components/PlaceMap.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:expandable/expandable.dart';

class AboutUs extends StatelessWidget {
  final Place place;

  AboutUs({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Text(
                    "About this place",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: darkGrey,
                        fontSize: 19.0),
                  ),
                  collapsed: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Text(place.description,
                          style: TextStyle(fontSize: 13, color: midGrey),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)),
                  expanded: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(place.description,
                              style: TextStyle(fontSize: 13, color: midGrey),
                              textAlign: TextAlign.justify,
                              softWrap: true),
                          Container(padding: EdgeInsets.only(top: 10)),
                          Divider(),
                          Container(padding: EdgeInsets.only(top: 10)),
                          Text("Location",
                              style: TextStyle(
                                fontFamily: 'SFUIText',
                                color: darkGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                              )),
                          Container(padding: EdgeInsets.only(top: 10)),
                          PlaceMap(place: place)
                        ],
                      )),
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
