import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/permission_controller.dart';
import '../../util/my_color.dart';
import '../../util/routes.dart';

class PermissionPage extends GetView<PermissionController> {
  const PermissionPage({super.key});
  static String route = '/permission';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text('권한 설정',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '여러분들의 다양한 컨텐츠 접근을 위해 안전하게 권한 설정을 하고 있습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(color: MyColor.primary2),
              ),
              const SizedBox(height: 60),
              Row(
                children: const [
                  Text(
                    '요구 권한',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.photo_camera,
                    color: MyColor.primary2,
                  ),
                  Text('사용자의 카메라 권한을 필요로 합니다.'),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.image,
                    color: MyColor.primary2,
                  ),
                  Text('사용자의 갤러리 권한을 필요로 합니다.'),
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.permission();
                  Get.offAndToNamed(AppRoute.explanation);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.primary2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text('확인'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
