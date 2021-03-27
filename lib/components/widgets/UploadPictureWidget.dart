import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikolla_neo/api/clients/CloudinaryShared.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class UploadPictureWidget {
  BuildContext context;
  Function afterSaved;

  UploadPictureWidget({this.context, this.afterSaved});

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
        child: new Text("Cancel", style: TextStyle(color: error)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: new Text("Select your picture source"),
      actions: <Widget>[
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
