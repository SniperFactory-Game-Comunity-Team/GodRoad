import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_dialog.dart';

class MyPage extends GetView<ProfileController> {
  const MyPage({super.key});
  static String route = '/my';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                  () => CircleAvatar(
                      radius: 80,
                      backgroundImage: controller.auth.userProfile!.profileUrl != ''
                          ? NetworkImage(controller.auth.userProfile!.profileUrl.toString())
                          : null),
                ),
                const SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.auth.userProfile!.nickname!,
                      style: const TextStyle(),
                    ),
                    Text(
                      controller.auth.userProfile!.email,
                      style: const TextStyle(),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.editProfile);
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        '프로필 수정',
                        style: TextStyle(),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  '이용약관',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Get.dialog(CustomDialog(
                    content: '로그아웃\n 하시겠습니까?',
                    btnOk: controller.auth.signOut,
                  ));
                },
                child: const Text(
                  '로그아웃',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                 onPressed: () {
                  Get.dialog(CustomDialog(
                    content: '계정 탈퇴\n 하시겠습니까?',
                    btnOk: controller.auth.userDelete,
                  ));
                },
                child: const Text(
                  '계정 탈퇴',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        ),
      )),
    );
  }
}
