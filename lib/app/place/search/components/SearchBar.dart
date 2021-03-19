import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../locations/components/Index.dart' as location;

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(Icons.search, color: darkGrey, size: 15),
        Padding(
          padding: EdgeInsets.only(right: 15),
        ),
        Expanded(
            child: ValueListenableBuilder(
                valueListenable: Hive.box<Session>(sessionsTable).listenable(),
                builder: (context, Box<Session> box, child) {
                  if (box.values.isEmpty) return Container();
                  Session session = box.values.first;

                  if (session.location == null) return Container();

                  return Text(session.location,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: darkGrey,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.3562500476837158,
                      ));
                })),
        Padding(padding: EdgeInsets.only(right: 10)),
        InkWell(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return location.Index();
                  });
            },
            child: Text("Change",
                style: TextStyle(
                  color: brightCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )))
      ]);
}
