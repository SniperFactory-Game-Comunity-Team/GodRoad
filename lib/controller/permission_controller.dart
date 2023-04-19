import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
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
}
