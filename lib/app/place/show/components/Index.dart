import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/place/show/components/Options.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({@required this.place}) : assert(place != null);

  List<Widget> _listNav() {
    List<Widget> actions = [];

    Widget _button(
        {@required String title,
        @required IconData iconData,
        @required Function onTap}) {
      return Padding(
          child: Container(
              padding: EdgeInsets.all(5),
              width: 90.0,
              height: 98,
              child: InkWell(
                  onTap: onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                          child: Icon(iconData, size: 18, color: midGrey),
                          alignment: Alignment.topLeft),
                      Expanded(child: Container()),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Align(
                              child: Text(title,
                                  style:
                                      TextStyle(color: midGrey, fontSize: 12)),
                              alignment: Alignment.bottomLeft))
                    ],
                  )),
              color: whiteDiv),
          padding: EdgeInsets.only(right: 15));
    }

    actions.add(
        _button(title: "Booking", iconData: Icons.book_online, onTap: () {}));
    actions.add(
        _button(title: "Table", iconData: Icons.restaurant_menu, onTap: () {}));
    actions.add(_button(
        title: "Service", iconData: Icons.kitchen_outlined, onTap: () {}));

    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(place.name, style: TextStyle(color: darkGrey)),
            leading: Container(
              padding: EdgeInsets.only(left: 25),
              child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                minWidth: 40.0,
                padding: EdgeInsets.all(0),
                child: Icon(Icons.arrow_back_ios,
                    color: Color.fromRGBO(165, 165, 165, 1.0)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 30, bottom: 20),
          child: Container(
              child: ListView(
                  scrollDirection: Axis.horizontal, children: _listNav()),
              height: 100),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Place>(hostPlacesTable).listenable(),
                  builder: (context, Box<Place> box, child) {
                    Place placeData = box.values
                        .firstWhere((element) => element.id == place.id);

                    return Options(box: box, place: placeData);
                  }))
        ]));
  }
}
