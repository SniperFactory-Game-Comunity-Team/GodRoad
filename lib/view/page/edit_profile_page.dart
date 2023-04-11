import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_dialog.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});
  static String route = '/editProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  MyBottomSheet(
                      firstText: '촬영하기',
                      secondText: '갤러리',
                      firstIcon: const FaIcon(FontAwesomeIcons.camera),
                      secondIcon: const FaIcon(FontAwesomeIcons.photoFilm),
                      fisrtFunction: () {
                        controller.profileUpload(ImageSource.camera);
                      },
                      secondFunction: () {
                        controller.profileUpload(ImageSource.gallery);
                      }),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  clipBehavior: Clip.hardEdge,
                );
              },
              child: Stack(children: [
                Obx(
                  () => CircleAvatar(
                      radius: 80,
                      backgroundImage: controller.profileUrl.value != ''
                          ? NetworkImage(controller.profileUrl.value)
                          : controller.auth.userProfile!.profileUrl != ''
                              ? NetworkImage(
                                  controller.auth.userProfile!.profileUrl!)
                              : null),
                ),
                const Positioned(
                    right: 10,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey,
                      child: FaIcon(
                        FontAwesomeIcons.camera,
                        size: 30,
                        color: Colors.black,
                      ),
                    ))
              ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('닉네임'),
                TextField(
                  onChanged: (value) => controller.uniqueNicknameCheck(),
                  controller: controller.nameController,
                  decoration: const InputDecoration(hintText: '닉네임을 입력해주세요'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => controller.isUniqueName.value
                      ? const Text(
                          '사용가능한 닉네임입니다',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        )
                      : controller.nameController.text != ''
                          ? const Text(
                              '중복된 닉네임입니다.',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )
                          : const SizedBox()),
                ),
              ],
            ),
            Obx(
              () => CustomButton(
                  text: '프로필 수정',
                  onPressedFunction: () {
                    Get.dialog(CustomDialog(
                      content: '프로필을\n 수정하시겠습니까?',
                      btnOk: () {
                        controller.updateProfile();
                        controller.auth.getProfile();
                      },
                    ));
                  },
                  isEnabled: controller.isUniqueName.value),
            )
          ],
        ),
      ),
    );
  }
}
