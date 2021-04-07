// import 'package:cloudinary_client/cloudinary_client.dart';
// import 'package:cloudinary_client/models/CloudinaryResponse.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:nikolla_neo/api/clients/ServerConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikolla_neo/api/clients/ServerConfig.dart';
import 'package:nikolla_neo/api/clients/cloudinary-client/CloudinaryClient.dart';
import 'package:nikolla_neo/api/clients/cloudinary-client/models/CloudinaryResponse.dart';

class CloudinaryShared {
  CloudinaryClient cloudinaryClient;

  static CloudinaryShared _instance;

  CloudinaryShared._();

  static CloudinaryShared get instance {
    if (_instance == null) {
      _instance = CloudinaryShared._();
      _instance.cloudinaryClient = CloudinaryClient(
          ServerConfig.cloudinaryApiKey,
          ServerConfig.cloudinaryApiSecret,
          ServerConfig.cloudinaryCloudName);
    }

    return _instance;
  }

  static String imageThumbAvatar({@required String publicId}) => baseUrl(
      path: "c_thumb,g_face,h_500,q_auto:best,w_500/v1590500389/$publicId");

  static String baseUrl({@required String path}) =>
      "https://res.cloudinary.com/${ServerConfig.cloudinaryCloudName}/image/upload/$path";

  Future<String> getPublicId(PickedFile file) async {
    EasyLoading.show();

    CloudinaryResponse response = await cloudinaryClient.uploadImage(file.path);

    EasyLoading.dismiss();

    return response.publicId;
  }
}
