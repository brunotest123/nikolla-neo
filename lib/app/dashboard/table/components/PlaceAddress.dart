import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class PlaceAddress extends StatelessWidget {
  final Place place;

  PlaceAddress({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(padding: EdgeInsets.only(top: 40)),
        Container(
            width: double.infinity,
            height: 90,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [Color(0xff25272a), Color(0xff3d3f43)],
                stops: [0, 1],
                begin: Alignment(-0.96, -0.28),
                end: Alignment(0.96, 0.28),
                // angle: 106,
                // scale: undefined,
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(0x2d000000),
                    offset: Offset(0, 6),
                    blurRadius: 12,
                    spreadRadius: 0)
              ],
            ),
            child: InkWell(
                onTap: () {},
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Padding(
                          padding:
                              EdgeInsets.only(top: 15, left: 15, bottom: 15),
                          child: _addressInfo())),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Image(
                    image: new AssetImage(
                        'lib/assets/imgAddressRestaurants@3x.png'),
                  )
                ])))
      ]);

  Widget _addressInfo() => Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Get direction",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: brightCyan,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ))),
          Container(padding: EdgeInsets.only(top: 15)),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("47 Mount Street Lower, Dublin 2",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: midGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ))),
          Container(padding: EdgeInsets.only(top: 5)),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("D02 TN83 - Dublin, Ireland",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: midGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ))),
        ],
      );
}
