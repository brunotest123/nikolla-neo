import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/CloudinaryShared.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class BoxOptions extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Function onTap;
  final bool showArrow;
  final bool warningText;
  final Color dividerColor;
  final String coverImagePath;

  BoxOptions(
      {@required this.titleText,
      @required this.onTap,
      this.subTitleText,
      this.showArrow,
      this.warningText,
      this.dividerColor,
      this.coverImagePath})
      : assert(titleText != null && onTap != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListTile(
              trailing: (showArrow == false
                  ? null
                  : Icon(Icons.keyboard_arrow_right)),
              subtitle: _subTitle(),
              onTap: onTap,
              title: Text(titleText,
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    color: (warningText == true ? error : warmGrey),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )))),
      ScreenContainer(
          child: Divider(
              color: (dividerColor != null ? dividerColor : lighterGrey)))
    ]);
  }

  Widget _subTitle() {
    if (this.coverImagePath == null || this.coverImagePath.trim().length == 0) {
      return (subTitleText == null
          ? null
          : Text(subTitleText,
              style: TextStyle(
                fontFamily: 'SFUIText',
                color: (warningText == true ? error : Color(0xff444444)),
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )));
    } else {
      return _images();
    }
  }

  Widget _images() {
    List<Widget> rows = [
      CachedNetworkImage(
          imageUrl:
              CloudinaryShared.imageThumbAvatar(publicId: this.coverImagePath),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()))
    ];

    return ScreenContainer(
        right: 0,
        left: 0,
        top: 10,
        bottom: 5,
        child: Container(
            height: 40,
            child: ListView(scrollDirection: Axis.horizontal, children: rows)));
  }
}
