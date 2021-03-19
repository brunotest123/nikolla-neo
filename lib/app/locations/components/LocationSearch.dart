import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:nikolla_neo/components/widgets/HeaderInfoWithTwoLines.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';

class LocationSearch extends StatefulWidget {
  final bool hiddenClose;
  final Function afterChooseLocation;
  final GoogleMapsGeocoding geocoding;

  LocationSearch(
      {this.hiddenClose,
      @required this.geocoding,
      @required this.afterChooseLocation});

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch>
    with WidgetsBindingObserver {
  final ValueNotifier<String> _textFilledNotifier = ValueNotifier("");
  GeocodingResponse _response = GeocodingResponse('', '', []);
  bool _requestPermission = false;

  _searchLocation(String value) async {
    _response = await widget.geocoding.searchByAddress(value);
    _textFilledNotifier.value = value;
  }

  Future _requireAccess() async {
    try {
      LocationPermission status = await Geolocator.checkPermission();

      if (status == LocationPermission.deniedForever) {
        await AppSettings.openLocationSettings();
        _requestPermission = true;
        return;
      }

      Position position = await Geolocator.getLastKnownPosition(
          forceAndroidLocationManager: Platform.isAndroid);
      widget.afterChooseLocation(
          Location(position.latitude, position.longitude), context);
      return;
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_requestPermission == true) _checkPermissionWhenResumed();

      _requestPermission = false;
    }
  }

  _checkPermissionWhenResumed() async {
    LocationPermission status = await Geolocator.checkPermission();

    if (status == LocationPermission.deniedForever) return;

    _requireAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (widget.hiddenClose != true
            ? AppBar(
                leading: Container(
                padding: EdgeInsets.only(left: 25),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  minWidth: 40.0,
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.clear,
                      color: Color.fromRGBO(165, 165, 165, 1.0)),
                  onPressed: () {
                    Navigator.pop(context);
                    return;
                  },
                ),
              ))
            : null),
        body: ListView(
          children: [
            ScreenContainer(
                top: (widget.hiddenClose != true ? 20 : 80),
                child: Row(children: [
                  HeaderInfoWithTwoLines(
                    firstLine: "Choose",
                    lastLine: "location",
                  ),
                  Expanded(child: Container()),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image:
                            new AssetImage('lib/assets/imgYourLocation@3x.png'),
                        width: 38.0,
                      ))
                ])),
            ScreenContainer(
                top: 30,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, size: 20),
                    hintText: 'Location',
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: (String value) {
                    _searchLocation(value);
                  },
                )),
            ScreenContainer(
                top: 15,
                child: Row(children: [
                  Padding(padding: EdgeInsets.only(right: 3)),
                  Icon(Icons.location_searching, color: midGrey, size: 13),
                  Padding(padding: EdgeInsets.only(right: 18)),
                  InkWell(
                      onTap: () {
                        _requireAccess();
                      },
                      child: Text("Use your location",
                          style: TextStyle(
                            fontFamily: 'SFUIText',
                            color: brightCyan,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.24374999105930328,
                          )))
                ])),
            ScreenContainer(
                top: 40,
                left: 63,
                right: 0,
                child: ValueListenableBuilder(
                    valueListenable: _textFilledNotifier,
                    builder: (context, value, child) {
                      if (value.toString().trim().length > 2 &&
                          _response.results.length == 0) {
                        return Text('No result for "$value"');
                      }

                      if (_response.results.length > 0) {
                        return Column(
                            children: _response.results
                                .map((result) => InkWell(
                                    onTap: () {
                                      widget.afterChooseLocation(
                                          result.geometry.location, context);
                                    },
                                    child: Column(children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(result.formattedAddress,
                                              style: TextStyle(
                                                color: midGrey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 0,
                                              ))),
                                      Padding(
                                          padding: EdgeInsets.only(top: 15)),
                                      Divider(),
                                      Padding(
                                          padding: EdgeInsets.only(top: 15)),
                                    ])))
                                .toList());
                      }

                      return Container();
                    }))
          ],
        ));
  }
}
