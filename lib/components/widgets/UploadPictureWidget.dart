import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikolla_neo/api/clients/CloudinaryShared.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class UploadPictureWidget {
  final BuildContext context;
  final Function afterSaved;
  final bool removeOptions;

  UploadPictureWidget(
      {@required this.context, @required this.afterSaved, this.removeOptions});

  openDialog() => showCupertinoModalPopup(
      context: context, builder: (BuildContext context) => _actionSheet());

  getImage(bool isCamera) async {
    Navigator.of(context).pop();

    PickedFile pickedFile = await ImagePicker().getImage(
        source: (isCamera ? ImageSource.camera : ImageSource.gallery));

    if (pickedFile == null) return;

    String publicId = await CloudinaryShared.instance.getPublicId(pickedFile);

    this.afterSaved(publicId);
  }

  Widget _actionSheet() {
    return CupertinoActionSheet(
      cancelButton: new CupertinoDialogAction(
        isDefaultAction: true,
        child: new Text("Cancel", style: TextStyle(color: darkGreyTwo)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: new Text("Select your picture source"),
      actions: <Widget>[
        (this.removeOptions == true
            ? CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  this.afterSaved('');
                },
                child: new Text("Remove", style: TextStyle(color: error)))
            : Container()),
        new CupertinoDialogAction(
            onPressed: () {
              getImage(false);
            },
            child: new Text("Choose existing")),
        new CupertinoDialogAction(
            onPressed: () {
              getImage(true);
            },
            child: new Text("Take photo"))
      ],
    );
  }
}
