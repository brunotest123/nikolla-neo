import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/models/HostProfile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'NameForm.dart';

import '../../../place/list/components/List.dart' as placeList;

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<HostProfile>(hostProfilesTable).listenable(),
      builder: (context, Box<HostProfile> box, child) {
        HostProfile hostProfile =
            (box.values.length == 0 ? HostProfile() : box.values.first);

        return (hostProfile.id == null
            ? NameForm(box: box, initalValue: hostProfile)
            : placeList.List());
      });
}
