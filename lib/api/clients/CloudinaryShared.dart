// import 'package:cloudinary_client/cloudinary_client.dart';
// import 'package:cloudinary_client/models/CloudinaryResponse.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:nikolla_neo/api/clients/ServerConfig.dart';
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

  Future<String> getPublicId(PickedFile file) async {
    EasyLoading.show();

    CloudinaryResponse response = await cloudinaryClient.uploadImage(file.path);

    EasyLoading.dismiss();

    return response.publicId;
  }
}
