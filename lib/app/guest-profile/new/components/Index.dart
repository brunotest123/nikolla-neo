import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Details.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../gateway/components/Index.dart' as gateway;

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<GuestProfile>(guestProfilesTable).listenable(),
      builder: (context, Box<GuestProfile> box, _) {
        GuestProfile guestProfile =
            (box.values.first == null ? GuestProfile() : box.values.first);

        if (guestProfile.id != null) return gateway.Index();

        return Details();
      });
}
