import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/routes.dart';

class PermissionController extends GetxController {
  static PermissionController get to => Get.find();
  Future<bool> permission() async {
    Map<Permission, PermissionStatus> status =
        await [Permission.camera, Permission.photos].request();

    if (await Permission.camera.isGranted &&
        await Permission.photos.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  permissionCheck() async {
    if (await Permission.camera.status == PermissionStatus.granted &&
        await Permission.photos.status == PermissionStatus.granted) {
      Get.offAndToNamed(AppRoute.explanation);
    } else {
      Get.offAndToNamed(AppRoute.permission);
    }
  }
}
